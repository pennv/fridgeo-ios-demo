//
//  PPShoppingListPopupWindowScrollView.swift
//  Fridge Helper
//
//  Created by Penn on 20/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPShoppingListPopupWindowScrollView: UIScrollView, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, ToolbarPickerViewDelegate {
    
    var pickerRow: Int?
    var categoryList: [NSDictionary]?

    let nameLabel = PPFridgeItemPopupWindowNameLabel()
    let nameTextField = PPFridgeItemPopupWindowNameTextField()
    let nameWarningLabel = PPFridgeItemPopupWindowNameWarningLabel()
    let needLabel = PPFridgeItemPopupWindowQuantityLabel()
    let needTextField = PPFridgeItemPopupWindowQuantityTextField()
    let needWarningLabel = PPFridgeItemPopupWindowQuantityWarningLabel()
    let nameTextFieldDropDown = PPShppingListPopupWindowNameTextFieldDropDownScrollView()
    let categoryLabel = PPFridgeItemPopupWindowCategoryLabel()
    let categoryTextField = PPFridgeItemPopupWindowCategoryTextField()
    let categortWarningLabel = PPFridgeItemPopupWindowCategoryWarningLabel()
    let categoryPicker = PPFridgeItemPopupWindowCategoryPickerView()
    
    let fridgeList = db.fridgeItemList
    
    init() {
        super.init(frame: .zero)
        // Set views
        nameTextField.delegate = self
        categoryTextField.delegate = self
        categoryTextField.inputView = categoryPicker
        categoryTextField.inputAccessoryView = categoryPicker.toolBar
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        categoryPicker.toolbarDelegate = self
        //needTextField.delegate = self
        frame = CGRect.PPFridgeItemPopupWindowScrollViewFrame
        contentSize = CGSize.PPFridgeItemPopupWindowScrollViewContentSize
        contentSize.height /= 3
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        needLabel.text = "Need"
        needTextField.placeholder = "Tap to set quantity of need"
        nameTextField.addTarget(self, action: #selector(onNameTextFieldChaned(_:)), for: [.editingChanged, .editingDidBegin])
        addSubview(nameLabel)
        addSubview(nameTextField)
        addSubview(nameWarningLabel)
        addSubview(needLabel)
        addSubview(needTextField)
        addSubview(needWarningLabel)
        addSubview(categoryLabel)
        addSubview(categoryTextField)
        addSubview(categortWarningLabel)
        addSubview(nameTextFieldDropDown)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onNameTextFieldChaned(_ textfield: UITextField) {
        // Retrive the category of item that matched name
        let name = textfield.text
        for item in db.fridgeItemList! {
            if item.object(forKey: "name") as? String == name {
                let category = item.object(forKey: "category") as? String
                categoryTextField.text = category?.capitalizingFirstLetter()
            }
        }
        // When user edits the item the name text field would be used
        // as need textfield
        if nameLabel.text == "Name*" {
            let text = textfield.text!.lowercased()
            var nameList: [String] = []
            nameTextFieldDropDown.subviews.forEach({ $0.removeFromSuperview() })
            // If name textfield is not empty
            if text.count > 0 {
                for item in fridgeList! {
                    let name = item.object(forKey: "name") as! String
                    if name.lowercased().contains(text) {
                        nameList.append(name)
                    }
                }
                // If there is any item name contained in input text
                if nameList.count > 0 {
                    nameTextFieldDropDown.isHidden = false
                    nameTextFieldDropDown.contentSize.height = CGFloat.PPShppingListPopupWindowNameTextFieldDropDownScrollViewLabelHeight*CGFloat(nameList.count)
                    // If there are less three found itmes, make the height of scroll
                    // view equal to height of labels
                    if nameList.count <= 3 {
                        nameTextFieldDropDown.frame.size.height = nameTextFieldDropDown.contentSize.height
                    } else if nameList.count > 3 {
                        nameTextFieldDropDown.frame.size.height = CGFloat.PPShppingListPopupWindowNameTextFieldDropDownScrollViewHeight
                    }
                    for (i, name) in nameList.enumerated() {
                        let label = PPShppingListPopupWindowNameTextFieldDropDownScrollViewLabel()
                        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onScrollNameLabelTapped(_:))))
                        label.text = name
                        label.frame.origin.y = CGFloat.PPShppingListPopupWindowNameTextFieldDropDownScrollViewLabelHeight*CGFloat(i)
                        nameTextFieldDropDown.addSubview(label)
                    }
                } else {
                    nameTextFieldDropDown.isHidden = true
                }
            } else {
                nameTextFieldDropDown.isHidden = true
            }
        }
    }
    
    @objc func onScrollNameLabelTapped(_ sender: UITapGestureRecognizer) {
        nameTextField.text = (sender.view as? UILabel)?.text
        nameTextField.sendActions(for: .editingChanged)
        nameTextFieldDropDown.isHidden = true
        endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // Reload category list every time when user click the category textfield
        let userProfile = UserDefaults.standard.dictionary(forKey: Key.userProfile)! as NSDictionary
        categoryList = userProfile.object(forKey: "category") as? [NSDictionary]
        categoryList?.insert(["name": "", "image": ""], at: 0)
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryList!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (categoryList![row]["name"] as? String)?.capitalizingFirstLetter()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        pickerRow = row
    }
    
    func didTapDone(_ sender: String) {
        self.endEditing(true)
        if sender == "category" {
            guard pickerRow == nil else {
                categoryTextField.text = (categoryList![pickerRow!]["name"] as? String)?.capitalizingFirstLetter()
                return
            }
        }
    }
    
    func didTapCancel() {
        self.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextFieldDropDown.isHidden = true
        endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextFieldDropDown.isHidden = true
        endEditing(true)
        return true
    }
}
