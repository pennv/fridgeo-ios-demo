//
//  FridgeItemCell.swift
//  Fridge Helper
//
//  Created by Penn on 26/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit
import IGListKit
import SwipeCellKit

class FridgeItemCell: SwipeCollectionViewCell {
    
    lazy fileprivate var nameLabel = PPFridgeItemListCellNameLabel()
    lazy fileprivate var categoryLabel = PPFridgeItemListCellCategoryLabel()
    lazy fileprivate var categoryImage = PPFridgeItemListCellCategoryImageView()
    lazy fileprivate var quantityLabel = PPFridgeItemListCellQuantityLabel()
    lazy fileprivate var shoppingImage = PPFridgeItemListCellShoppingCartButton()
    lazy fileprivate var minusImage = PPFridgeItemListCellMinusButton()
    lazy fileprivate var plusImage = PPFridgeItemListCellPlusButton()
    lazy fileprivate var border = PPFridgeListBorderView()
    
    var fridgeItem: FridgeItemViewModel?
    
    /*
     IGListKit will recycle the cells outside the screen and reuse them
     rather than making them destroied. Therefore, the reused cells will
     remine the view layout of first load so if you add any subview within
     bindViewModel() callback and change its layout based on the data from
     viewModel, the appearance of that layout on each cell would be messed
     especially in the scenario that some cell have this view and others do
     not, e.g. top cell with a border might be moved to be the bottom cell
     that do not have any border when user scrolls down and in this case the
     layout of top cell would not be changed (only subviews declared in
     layoutSubviews would be reloaded and border declared in bindViewModel
     of top cell would be remined as the data determines that the bottom cell
     would not access to any border declaration/redeclaration statement) so
     user would see the bottom cell turns up with an unexpcted border even
     the data is coorect.
     
     The good way to resolve this is to add all subviews within layoutSubviews()
     and only change the CONTENTS (e.g. color, border width) of subviews in
     the bindViewModel() so that the layout in bindViewModel() (loaded after
     layoutSubviews()) would cover all previous setting.
    */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = CGFloat.FridgeItemCellCornerRadius
        self.layer.shadowOpacity = CGFloat.FridgeItemCellShadowOpacity
        self.plusImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onPlusButtonClicked)))
        self.minusImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onMinusButtonClicked)))
        self.shoppingImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onShoppingButtonClicked)))
        self.contentView.addSubview(shoppingImage)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(categoryLabel)
        self.contentView.addSubview(categoryImage)
        self.contentView.addSubview(quantityLabel)
        self.contentView.addSubview(minusImage)
        self.contentView.addSubview(plusImage)
        self.contentView.addSubview(border)
        self.onThemeChanged()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        // Switch theme
        self.onThemeChanged()
    }
    
    func onThemeChanged() {
        if traitCollection.userInterfaceStyle == .light {
            self.backgroundColor = UIColor.PPCell.FridgeItemCellBackgroundColor.light
            self.layer.shadowColor = UIColor.black.cgColor
        } else {
            self.backgroundColor = UIColor.PPCell.FridgeItemCellBackgroundColor.dark
            self.layer.shadowColor = UIColor.white.cgColor
        }
    }
    
    @objc func onPlusButtonClicked() {
        var amount = UserDefaults.standard.double(forKey: "amount").rounded(digits: 1)
        if amount == 0 { amount = 1 }
        guard fridgeItem != nil && fridgeItem!.quantity + amount <= 99999 else {
            UIDevice.vibrateOnError()
            return
        }
        UIDevice.vibrateOnSuccess()
        let newQuantity = (fridgeItem!.quantity + amount).rounded(digits: 1)
        let dataToUpdate: [String : Any] = [Key.fridgeItemQuantity : newQuantity]
        db.updateFridgeItem(fridgeItemId: fridgeItem!._id, dataToUpdate: dataToUpdate)
    }
    
    @objc func onMinusButtonClicked() {
        var amount = UserDefaults.standard.double(forKey: "amount").rounded(digits: 1)
        if amount == 0 { amount = 1 }
        guard fridgeItem != nil && fridgeItem!.quantity - amount >= 0 else {
            UIDevice.vibrateOnError()
            return
        }
        UIDevice.vibrateOnSuccess()
        let newQuantity = (fridgeItem!.quantity - amount).rounded(digits: 1)
        let dataToUpdate: [String : Any] = [Key.fridgeItemQuantity : newQuantity]
        db.updateFridgeItem(fridgeItemId: fridgeItem!._id, dataToUpdate: dataToUpdate)
    }
    
    @objc func onShoppingButtonClicked() {
        if fridgeItem?.list == 0 {
            let quantityAlertController = UIAlertController(title: "Quantity you need", message: "", preferredStyle: .alert)
            quantityAlertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "(Optional)"
                textField.keyboardType = .decimalPad
            }
            quantityAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            quantityAlertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { alert -> Void in
                let textField = quantityAlertController.textFields![0] as UITextField
                let need = Double(textField.text!)
                if (need != nil && need! >= 0 && need! <= 99999) || textField.text! == "" {
                    UIDevice.vibrateOnSuccess()
                    self.shoppingImage.updateImage(imageName: "shopping_fridgeItemListCell_filled")
                    db.updateFridgeItem(fridgeItemId: self.fridgeItem!._id, dataToUpdate: ["list" : 1, "need" : need ?? ""])
                    return
                }
                let alert = UIAlertController(title: "Sorry", message: "Quantity must not be more than 99999 and less than 0", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }))
            window?.rootViewController?.present(quantityAlertController, animated: true, completion: nil)
        } else if fridgeItem?.list == 1 {
            shoppingImage.updateImage(imageName: "shopping_fridgeItemListCell")
            db.updateFridgeItem(fridgeItemId: fridgeItem!._id, dataToUpdate: ["list" : 0, "need" : ""])
        }
        UIDevice.vibrateOnSuccess()
    }
}

extension FridgeItemCell: ListBindable {
    
    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? FridgeItemViewModel else { return }
        self.fridgeItem = viewModel
        nameLabel.text = viewModel.name
        if floor(viewModel.quantity) == viewModel.quantity {
            quantityLabel.text = String(Int(viewModel.quantity))
        } else { quantityLabel.text = String(viewModel.quantity) }
        // Determain the shopping cart image (filled or not)
        let list = viewModel.list
        if list == 1 {
            shoppingImage.updateImage(imageName: "shopping_fridgeItemListCell_filled")
        } else {
            shoppingImage.updateImage(imageName: "shopping_fridgeItemListCell")
        }
        // Retrive category image
        categoryLabel.text = "Category: "
        let userProfile = UserDefaults.standard.dictionary(forKey: Key.userProfile) as NSDictionary?
        let categoryList = userProfile!.object(forKey: "category") as? [NSDictionary]
        let categoryName = viewModel.category
        var categoryImageName = ""
        for item in categoryList! {
            if item.object(forKey: "name") as? String == categoryName {
                categoryImageName = item.object(forKey: "image") as! String
            }
        }
        // If user did not specify the category, use bucket image
        if categoryImageName == "" {
            categoryImage.image = UIImage.bucketImage
        } else { categoryImage.image = UIImage(named: categoryImageName) }
        // Determain the color of date indicator
        let days = self.getDays(viewModel.date)
        if days == nil {
            self.border.changeColor(.clear)
        } else if days == 0 {
            self.border.changeColor(UIColor.PPCell.FridgeItemCellBorderColor.red)
        } else if days! >= 1 && days! <= 7 {
            self.border.changeColor(UIColor.PPCell.FridgeItemCellBorderColor.yellow)
        } else if days! > 7 {
            self.border.changeColor(UIColor.PPCell.FridgeItemCellBorderColor.green)
        } else {
            self.border.changeColor(UIColor.PPCell.FridgeItemCellBorderColor.gray)
        }
    }
    
    func getDays(_ rawDate: String?) -> Int? {
        if rawDate == nil || rawDate == "" { return nil }
        // Number of days from tody to expired date
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        var utc = formatter.date(from: rawDate!)
        // First formatter is for date from server,
        // second formatter is for date from local
        // popup window update (through dataUpdated
        // observer) as successful updated item will
        // not be the same format as the one from server
        if utc == nil {
            formatter.dateFormat = "yyyy/MM/dd"
            utc = formatter.date(from: rawDate!)
        }
        formatter.timeZone = .current
        let local = formatter.string(from: utc!)
        let day = local[8 ..< 10]
        let month = local[5 ..< 7]
        let year = local[0 ..< 4]
        let ExpiredDateString = year + "-" + month + "-" + day
        formatter.dateFormat = "yyyy-MM-dd"
        let expiredDate = formatter.date(from: ExpiredDateString)
        let days = Calendar.current.dateComponents([.day], from: Date(), to: expiredDate!).day
        return days!
    }
}

