//
//  PPCategoryPopupWindowView.swift
//  Fridge Helper
//
//  Created by Penn on 16/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit
import IGListKit

class PPCategoryPopupWindowView: PPPopupWindowView, ListAdapterDataSource, UITextFieldDelegate {
        
    var categoryList: [NSDictionary]?
    var isEditing: Bool?
    var categorySelectedIndex: Int?
    lazy var imageName: String = "category_meat"
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: nil)
    }()
    
    let categoryCollectionView = PPCategoryCollectionView()
    let titleLabel = PPProfilePopupWindowTitleLabel()
    let addButton = PPCategoryAddButton()
    let saveButton = PPCategoryViewSaveButton()
    lazy var nameLengthWarningLabel = PPCategoryTextFieldWarningLabel()
    lazy var backButton = PPCategoryBackButton()
    lazy var categoryNameTextField = PPCategoryNameTextField()
    lazy var categoryTextFieldImageView = PPCategoryTextFieldImageView()
    lazy var okButton = PPCategoryImageViewOKButton()
    
    override init() {
        super.init()
        adapter.collectionView = categoryCollectionView
        adapter.dataSource = self
        categoryNameTextField.delegate = self
        titleLabel.text = "Edit Categories"
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onBackButtonClicked)))
        addButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onAddButtonClicked)))
        okButton.addTarget(self, action: #selector(onOkButtonClicked), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(onSaveButtonClicked), for: .touchUpInside)
        // Observer for user updated
        NotificationCenter.default.addObserver(self, selector: #selector(onUserUpdated(_:)), name: .userUpdated, object: nil)
        // Observer for data updated
        NotificationCenter.default.addObserver(self, selector: #selector(onCategoryUpdated(_:)), name: .categoryUpdated, object: nil)
        // Observer for cell selected
        NotificationCenter.default.addObserver(self, selector: #selector(onCategoryCellSelected(_:)), name: .categoryCellSelected, object: nil)
        addSubview(titleLabel)
        addSubview(categoryCollectionView)
        addSubview(addButton)
        addSubview(saveButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onCategoryCellSelected(_ notification: Notification) {
        // Notification from category list section controller
        if notification.userInfo!["selectedCategory"] as? NSDictionary != nil {
            let selectedCategory = notification.userInfo!["selectedCategory"] as! NSDictionary
            let categoryName = selectedCategory.object(forKey: "name") as! String
            let imageName = selectedCategory.object(forKey: "image") as! String
            for (i, item) in self.categoryList!.enumerated() {
                if item.object(forKey: "name") as! String == categoryName {
                    self.categorySelectedIndex = i
                }
            }
            self.categoryTextFieldImageView.image = UIImage(named: imageName)
            self.categoryNameTextField.text = categoryName.capitalizingFirstLetter()
            self.imageName = imageName
            self.onAddButtonClicked()
        // Notification from image list (editing view)
        } else {
            self.imageName = notification.userInfo!["imageName"] as! String
            self.categoryTextFieldImageView.image = UIImage(named: self.imageName)
        }
    }
    
    
    // This method will be called from delete button of category cell
    // and OK button of category adding view
    @objc func onCategoryUpdated(_ notification: Notification) {
        let userInfo = notification.userInfo
        if userInfo!["deletingCategory"] != nil {
            let category = userInfo!["deletingCategory"] as! NSDictionary
            for (i, item) in self.categoryList!.enumerated() {
                if item.object(forKey: "name") as! String == category.object(forKey: "name") as! String {
                    self.categoryList!.remove(at: i)
                }
            }
        } else if userInfo!["addingCategory"] != nil {
            let category = userInfo!["addingCategory"] as! NSDictionary
            self.categoryList?.append(category)
        }
        self.adapter.performUpdates(animated: true, completion: nil)
    }
    
    @objc func onAddButtonClicked() {
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
            self.frame.origin.x = CGFloat.width
            self.alpha = 0
        }, completion: { _ in
            self.isEditing = true
            self.adapter.collectionView?.frame = CGRect.PPCategoryimageCollectionViewFrame
            self.adapter.performUpdates(animated: false, completion: nil)
            self.addButton.removeFromSuperview()
            self.saveButton.removeFromSuperview()
            self.closeButton.removeFromSuperview()
            self.addSubview(self.backButton)
            self.addSubview(self.okButton)
            self.addSubview(self.categoryNameTextField)
            self.addSubview(self.categoryTextFieldImageView)
            self.addSubview(self.nameLengthWarningLabel)
            self.frame.origin.x = -CGFloat.PPPopupWindowViewWidth
            UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                self.frame.origin.x = CGFloat.PPPopupWindowViewPositionX
                self.alpha = 1
            })
        })
    }
    
    @objc func onBackButtonClicked() {
        self.finishEditingCategory()
    }
    
    @objc func onSaveButtonClicked() {
        displayLoadingIndicator()
        // The updated category list will be firstly saved into user default
        // then retrived by fridge item list controller after received
        // notification from delegate
        let userProfile = UserDefaults.standard.dictionary(forKey: Key.userProfile)! as NSDictionary
        let id = userProfile.object(forKey: "id") as! String
        db.updateUser(id: id, categoryList: categoryList!)
    }
    
    @objc func onUserUpdated(_ notification: Notification) {
        if let error = notification.userInfo!["error_updateUser"] as? String {
            // Dismiss loading indicator and display the alert
            UIApplication.shared.windows.first!.rootViewController!.dismiss(animated: true, completion: {
                self.displayAlert(name: "Failed to Update Category", message: error)
            })
        } else {
            onCloseButtonClicked()
        }
    }
    
    @objc func onOkButtonClicked() {
        let categoryName = self.categoryNameTextField.text?.lowercased()
        if self.categoryList!.count > 11 {
            self.sendAlert("No more than 12 categories")
            return
        }
        if categoryName == nil || categoryName == "" {
            self.sendAlert("Name cannot be empty")
            return
        }
        if categoryName! == "all" || categoryName! == "＋" {
            self.sendAlert("Name cannot be 'All' or '＋'")
            return
        }
        if categoryName!.count > 16 {
            self.sendAlert("Length of name cannot be more than 16 letters")
            return
        }
        for (i, item) in self.categoryList!.enumerated() {
            if categoryName! == item.object(forKey: "name") as! String && (self.categorySelectedIndex == nil || self.categorySelectedIndex != i) {
                self.sendAlert("Duplicate name")
                return
            }
        }
        // New category name validated
        if self.categorySelectedIndex == nil {
            self.categoryList?.append(["name" : categoryName!, "image" : self.imageName])
            self.finishEditingCategory()
            self.imageName = "category_meat"
            return
        }
        // Existing category name validated
        self.categoryList?[self.categorySelectedIndex!] = ["name" : categoryName!, "image" : self.imageName]
        self.categorySelectedIndex = nil
        self.finishEditingCategory()
        return
    }
    
    func sendAlert(_ text: String) {
        self.nameLengthWarningLabel.text = text
        UIDevice.vibrateOnError()
        self.categoryNameTextField.shake()
    }
    
    func finishEditingCategory() {
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
            self.frame.origin.x = -CGFloat.PPPopupWindowViewWidth
            self.alpha = 0
        }, completion: { _ in
            self.isEditing = false
            self.adapter.collectionView?.frame = CGRect.PPCategoryCollectionViewFrame
            self.adapter.performUpdates(animated: false, completion: nil)
            self.categoryNameTextField.text = nil
            self.nameLengthWarningLabel.text = nil
            self.categoryTextFieldImageView.image = UIImage(named: "category_meat")
            self.categoryNameTextField.removeFromSuperview()
            self.okButton.removeFromSuperview()
            self.categoryTextFieldImageView.removeFromSuperview()
            self.backButton.removeFromSuperview()
            self.nameLengthWarningLabel.removeFromSuperview()
            self.addSubview(self.addButton)
            self.addSubview(self.saveButton)
            self.addSubview(self.closeButton)
            self.frame.origin.x = CGFloat.width
            UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                self.frame.origin.x = CGFloat.PPPopupWindowViewPositionX
                self.alpha = 1
            })
        })
    }
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        // Editing view is not opened, load category list
        if self.isEditing != true { // Might be false or nil
            if self.categoryList == nil {
                // Retrive user category
                let userProfile = UserDefaults.standard.dictionary(forKey: Key.userProfile) as NSDictionary?
                guard userProfile != nil else {
                    print("FH: failed to load category as user profile is nil...")
                    return [ListDiffable]()
                }
                self.categoryList = userProfile!.object(forKey: "category") as? [NSDictionary]
            }
            var categoryViewModels: [CategoryViewModel] = []
            for item in self.categoryList! {
                categoryViewModels.append(CategoryViewModel(category: item))
            }
            return categoryViewModels
        // Editing view is opened, load category images
        } else {
            return UIImage.categoryImages as [ListDiffable]
        }
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if self.isEditing != true { return CategorySectionController() }
        else { return EditingCategorySectionController() }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        categoryNameTextField.resignFirstResponder()
        return true
    }
    
    func displayAlert(name: String, message: String) {
        let alertController = UIAlertController(title: name, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style:
            UIAlertAction.Style.default,handler: nil))
        // Present alert from the root view controller
        UIApplication.shared.windows.first!.rootViewController!.present(alertController, animated: true, completion: nil)
        print("FH: alert \"", name, "\" has been displayed...")
    }
    
    func displayLoadingIndicator() {
        let loadingAlert = UIAlertController(title: nil, message: "Updating category...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()
        loadingAlert.view.addSubview(loadingIndicator)
        UIApplication.shared.windows.first!.rootViewController!.present(loadingAlert, animated: true, completion: nil)
    }
}
