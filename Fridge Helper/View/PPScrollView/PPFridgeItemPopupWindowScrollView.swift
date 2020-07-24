//
//  PPFridgeItemPopupWindowScrollView.swift
//  Fridge Helper
//
//  Created by Penn on 28/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPFridgeItemPopupWindowScrollView: UIScrollView, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, ToolbarPickerViewDelegate {
    
    var pickerRow: Int?
    var categoryList: [NSDictionary]?
    
    let nameLabel = PPFridgeItemPopupWindowNameLabel()
    let nameTextField = PPFridgeItemPopupWindowNameTextField()
    let nameWarningLabel = PPFridgeItemPopupWindowNameWarningLabel()
    let quantityLabel = PPFridgeItemPopupWindowQuantityLabel()
    let quantityTextField = PPFridgeItemPopupWindowQuantityTextField()
    let quantityWarningLabel = PPFridgeItemPopupWindowQuantityWarningLabel()
    let categoryLabel = PPFridgeItemPopupWindowCategoryLabel()
    let categoryTextField = PPFridgeItemPopupWindowCategoryTextField()
    let categortWarningLabel = PPFridgeItemPopupWindowCategoryWarningLabel()
    let categoryPicker = PPFridgeItemPopupWindowCategoryPickerView()
    let dateLabel = PPFridgeItemPopupWindowDateLabel()
    let dateTextField = PPFridgeItemPopupWindowDateTextField()
    let dateWarningLabel = PPFridgeItemPopupWindowDateWarningLabel()
    let datePicker = PPFridgeItemPopupWindowDatePickerView()
    let barcodeLabel = PPFridgeItemPopupWindowBarcodeLabel()
    let barcodeTextField = PPFridgeItemPopupWindowBarcodeTextField()
    let barcodeWarningLabel = PPFridgeItemPopupWindowBarcodeWarningLabel()
    let noteLabel = PPFridgeItemPopupWindowNoteLabel()
    let noteTextView = PPFridgeItemPopupWindowNoteTextView()
    let noteWarningLabel = PPFridgeItemPopupWindowNoteWarningLabel()
    
    init() {
        super.init(frame: .zero)
        // Set views
        nameTextField.delegate = self
        quantityTextField.delegate = self
        categoryTextField.delegate = self
        categoryTextField.inputView = categoryPicker
        categoryTextField.inputAccessoryView = categoryPicker.toolBar
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        categoryPicker.toolbarDelegate = self
        dateTextField.delegate = self
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = datePicker.toolBar
        datePicker.toolbarDelegate = self
        barcodeTextField.delegate = self
        noteTextView.delegate = self
        frame = CGRect.PPFridgeItemPopupWindowScrollViewFrame
        contentSize = CGSize.PPFridgeItemPopupWindowScrollViewContentSize
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        addSubview(nameLabel)
        addSubview(nameTextField)
        addSubview(nameWarningLabel)
        addSubview(quantityLabel)
        addSubview(quantityTextField)
        addSubview(quantityWarningLabel)
        addSubview(categoryLabel)
        addSubview(categoryTextField)
        addSubview(dateLabel)
        addSubview(dateTextField)
        addSubview(barcodeLabel)
        addSubview(barcodeTextField)
        addSubview(noteLabel)
        addSubview(noteTextView)
        addSubview(categortWarningLabel)
        addSubview(dateWarningLabel)
        addSubview(barcodeWarningLabel)
        addSubview(noteWarningLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
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
        } else if sender == "date" {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"
            let selectedDate = dateFormatter.string(from: datePicker.date)
            dateTextField.text = selectedDate
        }
    }
    
    func didTapCancel() {
        self.endEditing(true)
    }
}
