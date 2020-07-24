//
//  PPFridgeItemPopupWindowView.swift
//  Fridge Helper
//
//  Created by Penn on 28/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPFridgeItemPopupWindowView: PPPopupWindowView, UITextFieldDelegate {
    
    var fridgeItemId: String?
    var selectedFridgeItem: NSDictionary?
    
    let titleLabel = PPProfilePopupWindowTitleLabel()
    let scrollView = PPFridgeItemPopupWindowScrollView()
    let saveButton = PPFridgeItemPopupWindowViewSaveButton()
    
    init(selectedFridgeItem: NSDictionary? = nil) {
        super.init()
        self.selectedFridgeItem = selectedFridgeItem
        // When user addes a new item by add button, quantity would be
        // empty, as well as adding by scanner since only barcode and
        // name can be got so quantity would also be empty. Besides,
        // if user searches by scanner,the full item matched would be
        // passed to this window or alert would be displayed, which means
        // no partial item (item without quantity) would be passed.
        if selectedFridgeItem?.object(forKey: "quantity") as? Double == nil {
            titleLabel.text = "New Item"
            // In case user scan to add and barcode found in database
            if selectedFridgeItem?.object(forKey: "name") != nil {
                scrollView.nameTextField.text = selectedFridgeItem!.object(forKey: "name") as? String
                scrollView.barcodeTextField.text = selectedFridgeItem!.object(forKey: "barcode") as? String
            }
        } else {
            titleLabel.text = "Edit Item"
            fridgeItemId = selectedFridgeItem!.object(forKey: "_id") as? String
            scrollView.nameTextField.text = selectedFridgeItem!.object(forKey: "name") as? String
            scrollView.categoryTextField.text = (selectedFridgeItem!.object(forKey: "category") as? String)?.capitalizingFirstLetter()
            scrollView.dateTextField.text = getLocalDate(selectedFridgeItem!.object(forKey: "date") as? String)
            scrollView.barcodeTextField.text = selectedFridgeItem!.object(forKey: "barcode") as? String
            scrollView.noteTextView.text = selectedFridgeItem!.object(forKey: "note") as? String
            // Remove decimal when it is integer
            if let quantity = selectedFridgeItem!.object(forKey: "quantity") as? Double {
                if floor(quantity) == quantity {
                    scrollView.quantityTextField.text = Int(quantity).description
                } else { scrollView.quantityTextField.text = quantity.description }
            }
        }
        saveButton.addTarget(self, action: #selector(onSaveButtonClicked), for: .touchUpInside)
        addSubview(titleLabel)
        addSubview(scrollView)
        addSubview(saveButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        scrollView.nameTextField.endEditing(true)
    }
    
    @objc func onSaveButtonClicked() {
        let name = scrollView.nameTextField.text
        let quantity = Double(scrollView.quantityTextField.text!)?.rounded(digits: 1)
        let category = scrollView.categoryTextField.text?.lowercased()
        let date = scrollView.dateTextField.text
        let barcode = scrollView.barcodeTextField.text
        let note = scrollView.noteTextView.text
        // New fridge item
        var newFridgeItem: [String : Any] = [:]
        // Validate name
        if name == "" || name!.count > 64 {
            scrollView.nameWarningLabel.text = "Name cannot be empty and must be less than 64 letters"
            scrollView.nameTextField.shake()
            UIDevice.vibrateOnError()
            return
        }
        newFridgeItem["name"] = name
        // Validate quantity
        if quantity == nil {
            scrollView.quantityWarningLabel.text = "Quantity cannot be empty and must be a number"
            scrollView.quantityTextField.shake()
            UIDevice.vibrateOnError()
            return
        }
        if quantity! > 99999 || quantity! < 0 {
            scrollView.quantityWarningLabel.text = "Quantity cannot be less than 0 or greater than 99999"
            scrollView.quantityTextField.shake()
            UIDevice.vibrateOnError()
            return
        }
        newFridgeItem["quantity"] = quantity
        // Validate category
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
        newFridgeItem["category"] = category
        // Validate date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let selectedDate = dateFormatter.date(from: date!)
        if selectedDate == nil && date! != "" {
            scrollView.dateWarningLabel.text = "Illegal date"
            scrollView.dateWarningLabel.shake()
            UIDevice.vibrateOnError()
            return
        }
        newFridgeItem["date"] = date
        // Validate barcode
        if barcode!.count > 64 {
            scrollView.barcodeWarningLabel.text = "Barcode must be less than 64 letters"
            scrollView.barcodeWarningLabel.shake()
            UIDevice.vibrateOnError()
        }
        newFridgeItem["barcode"] = barcode
        // Validate note
        if note!.count > 128 {
            scrollView.noteWarningLabel.text = "Note must be less than 128 letters"
            scrollView.noteWarningLabel.shake()
            UIDevice.vibrateOnError()
            return
        }
        newFridgeItem["note"] = note
        // Update exsiting item
        guard fridgeItemId == nil else {
            db.updateFridgeItem(fridgeItemId: fridgeItemId!, dataToUpdate: newFridgeItem)
            self.onCloseButtonClicked()
            return
        }
        // Save new fridge item to remote.
        // As the id of new fridge item must be generated by database,
        // user must wait for remote process finished (new item returned).
        // Upon new item successful added, database controller will
        // update fridgeItemList through dataUpdated observer.
        displayLoadingIndicator()
        db.addFridgeItem(newFridgeItem: newFridgeItem as NSDictionary) { updatedFridgeItemList, error in
            if error != nil {
                // Dismiss loading indicator and display the alert
                UIApplication.shared.windows.first!.rootViewController!.dismiss(animated: true, completion: {
                    self.displayAlert(name: "Failed to Add Fridge Item", message: error!)
                })
            } else {
                let userInfo = ["fridgeItemList" : updatedFridgeItemList]
                NotificationCenter.default.post(name: .dataUpdated, object: self, userInfo: userInfo as [AnyHashable : Any])
                self.onCloseButtonClicked()
            }
        }
        // Add barcode to database when it is not found (param contains no name)
        let paramName = selectedFridgeItem?["name"] as? String
        let paramBarcode = selectedFridgeItem?["barcode"] as? String
        if paramName == nil && paramBarcode != nil && barcode != nil {
            db.addBarcode(barcode: barcode!, name: name!)
        }
    }
    
    func getLocalDate(_ rawDate: String?) -> String? {
        if rawDate == nil || rawDate == "" { return nil }
        // Number of days from tody to expired date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let utc = formatter.date(from: rawDate!)
        // First formatter is for date from server,
        // second formatter is for date from local
        // popup window update (through dataUpdated
        // observer) as successful updated item will
        // not be the same format as the one from server
        if utc == nil { return rawDate }
        formatter.timeZone = .current
        formatter.dateFormat = "yyyy/MM/dd"
        let localDate = formatter.string(from: utc!)
        return localDate
    }
    
    func displayAlert(name: String, message: String) {
        let alertController = UIAlertController(title: name, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style:
            UIAlertAction.Style.default,handler: nil))
        // Present alert from the root view controller
        UIApplication.shared.windows.first!.rootViewController!.present(alertController, animated: true, completion: nil)
        print("FH: alert \"\(name)\" has been displayed...")
    }
    
    func displayLoadingIndicator() {
        let loadingAlert = UIAlertController(title: nil, message: "Adding fridge item...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()
        loadingAlert.view.addSubview(loadingIndicator)
        UIApplication.shared.windows.first!.rootViewController!.present(loadingAlert, animated: true, completion: nil)
    }
}
