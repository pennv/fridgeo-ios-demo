//
//  PPShppingListPopupWindowView.swift
//  Fridge Helper
//
//  Created by Penn on 20/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPShppingListPopupWindowView: PPPopupWindowView {

    var fridgeItemId: String?
    var selectedShoppingItem: NSDictionary?
    
    let titleLabel = PPProfilePopupWindowTitleLabel()
    let scrollView = PPShoppingListPopupWindowScrollView()
    let saveButton = PPFridgeItemPopupWindowViewSaveButton()
    
    init(selectedShoppingItem: NSDictionary? = nil) {
        super.init()
        self.selectedShoppingItem = selectedShoppingItem
        // If user chooses to edit shopping list item
        if selectedShoppingItem?.object(forKey: "name") as? String != nil {
            fridgeItemId = selectedShoppingItem!.object(forKey: "_id") as? String
            titleLabel.text = "Edit Item"
            scrollView.needLabel.removeFromSuperview()
            scrollView.needTextField.removeFromSuperview()
            scrollView.needWarningLabel.removeFromSuperview()
            scrollView.nameLabel.text = "Need"
            scrollView.nameTextField.placeholder = "Tap to set quantity you need"
            // Display category
            scrollView.categoryTextField.text = (selectedShoppingItem!.object(forKey: "category") as? String)?.capitalizingFirstLetter()
            // Display need if exists
            if let need = selectedShoppingItem!.object(forKey: "need") as? Double {
                if floor(need) == need {
                    scrollView.nameTextField.text = Int(need).description
                } else { scrollView.nameTextField.text = need.description }
            }
            // Adjust the position of category textfield
            scrollView.categoryLabel.frame = scrollView.needLabel.frame
            scrollView.categoryTextField.frame = scrollView.needTextField.frame
            scrollView.categortWarningLabel.frame = scrollView.needWarningLabel.frame
        // If user chooses to add new shopping list item
        } else {
            titleLabel.text = "New Item"
        }
        saveButton.addTarget(self, action: #selector(onSaveButtonClicked), for: .touchUpInside)
        addSubview(titleLabel)
        addSubview(scrollView)
        addSubview(saveButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func onSaveButtonClicked() {
        // Validate category
        let category = scrollView.categoryTextField.text?.lowercased()
        let userProfile = UserDefaults.standard.dictionary(forKey: Key.userProfile)! as NSDictionary
        let categoryList = userProfile.object(forKey: "category") as! [NSDictionary]
        var categoryNameList: [String] = [""] // First element should be blank
        for item in categoryList {
            categoryNameList.append(item.object(forKey: "name") as! String)
        }
        if !(categoryNameList.contains(category!)) {
            scrollView.categortWarningLabel.text = "Unknown category"
            scrollView.categortWarningLabel.shake()
            UIDevice.vibrateOnError()
            return
        }
        // If user chooses to edit shopping list item
        if selectedShoppingItem?.object(forKey: "name") as? String != nil {
            let need = Double(scrollView.nameTextField.text!)?.rounded(digits: 1)
            // Validate need
            if need == nil && scrollView.nameTextField.text! != "" {
                scrollView.nameWarningLabel.text = "Quantity of need must be a number"
                scrollView.nameTextField.shake()
                UIDevice.vibrateOnError()
                return
            }
            if need != nil {
                if need! > 99999 || need! < 0 {
                    scrollView.nameWarningLabel.text = "Quantity of need cannot be less than 0 or greater than 99999"
                    scrollView.nameTextField.shake()
                    UIDevice.vibrateOnError()
                    return
                }
            }
            db.updateFridgeItem(fridgeItemId: fridgeItemId!, dataToUpdate: ["need" : need ?? "", "category" : category ?? ""])
            onCloseButtonClicked()
        // If user chooses to add a new shopping list item
        } else {
            let name = scrollView.nameTextField.text!
            let need = Double(scrollView.needTextField.text!)?.rounded(digits: 1)
            let fridgeList = db.fridgeItemList!
            // If the name user entered is matched one of the fridge items
            for item in fridgeList {
                if item.object(forKey: "name") as! String == name {
                    db.updateFridgeItem(fridgeItemId: item.object(forKey: "_id") as! String, dataToUpdate: ["list" : 1, "need" : need ?? "", "category" : category ?? ""])
                    onCloseButtonClicked()
                    return
                }
            }
            // If user has not added the item with such a name
            let userProfile = UserDefaults.standard.dictionary(forKey: Key.userProfile)! as NSDictionary
            guard let purchaseQuantity = userProfile.object(forKey: "purchase") as? Int else {
                displayAlert(name: "Sorry", message: "Something happened to the purchase number")
                return
            }
            // If user attemps to add more item more than it purchased,
            // display purchase view
            if db.fridgeItemList!.count >= purchaseQuantity {
                // Display purchase view
                window?.rootViewController!.present(PurchaseViewController(), animated: true, completion: nil)
                return
            }
            displayLoadingIndicator(message: "Adding fridge item...")
            db.addFridgeItem(newFridgeItem: ["name" : name, "quantity" : 0, "list" : 1, "need" : need ?? "", "category" : category ?? ""]) { updatedFridgeItemList, error in
                if error == nil {
                    let userInfo = ["fridgeItemList" : updatedFridgeItemList]
                    NotificationCenter.default.post(name: .dataUpdated, object: self, userInfo: userInfo as [AnyHashable : Any])
                    self.onCloseButtonClicked()
                } else {
                    // Dismiss loading indicator and display the alert
                    UIApplication.shared.windows.first!.rootViewController!.dismiss(animated: true, completion: {
                        self.displayAlert(name: "Failed to Add Shopping Item", message: error!)
                    })
                }
            }
        }
    }
    
    func displayAlert(name: String, message: String) {
        let alertController = UIAlertController(title: name, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style:
            UIAlertAction.Style.default,handler: nil))
        // Present alert from the root view controller
        UIApplication.shared.windows.first!.rootViewController!.present(alertController, animated: true, completion: nil)
        print("FH: alert \"\(name)\" has been displayed...")
    }
    
    func displayLoadingIndicator(message: String? = nil) {
        let loadingAlert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()
        loadingAlert.view.addSubview(loadingIndicator)
        UIApplication.shared.windows.first!.rootViewController!.present(loadingAlert, animated: true, completion: nil)
    }
}
