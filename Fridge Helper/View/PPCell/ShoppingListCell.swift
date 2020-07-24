//
//  ShoppingListCell.swift
//  Fridge Helper
//
//  Created by Penn on 18/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit
import IGListKit
import SwipeCellKit

class ShoppingListCell: SwipeCollectionViewCell {

    var shoppingItem: FridgeItemViewModel?
    lazy fileprivate var categoryImage = PPShoppingListCellCategoryImageView()
    lazy fileprivate var nameLabel = PPShoppingListCellNameLabel()
    lazy fileprivate var needLabel = PPShoppingListCellNeedLabel()
    lazy fileprivate var tickButton = PPShoppingListCellTickButton()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = CGFloat.FridgeItemCellCornerRadius
        layer.shadowOpacity = CGFloat.FridgeItemCellShadowOpacity
        tickButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTickButtonClicked)))
        contentView.addSubview(categoryImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(needLabel)
        contentView.addSubview(tickButton)
        onThemeChanged()
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
    
    
    @objc func onTickButtonClicked() {
        let quantityAlertController = UIAlertController(title: "Quantity to add", message: "", preferredStyle: .alert)
        quantityAlertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "(Optional)"
            textField.keyboardType = .decimalPad
            if self.shoppingItem?.need != nil {
                if floor(self.shoppingItem!.need!) == self.shoppingItem!.need! {
                    textField.text = String(Int(self.shoppingItem!.need!))
                } else { textField.text = String(self.shoppingItem!.need!) }
            } else { textField.text = "" }
        }
        quantityAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        quantityAlertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { alert -> Void in
            let textField = quantityAlertController.textFields![0] as UITextField
            let need = Double(textField.text!)
            if (need != nil && need! >= 0 && need! <= 99999) || textField.text! == "" {
                UIDevice.vibrateOnSuccess()
                db.updateFridgeItem(fridgeItemId: self.shoppingItem!._id, dataToUpdate: ["list" : 0, "need" : "", "quantity" : self.shoppingItem!.quantity + (need ?? 0)])
                return
            }
            let alert = UIAlertController(title: "Sorry", message: "Quantity must not be more than 99999 and less than 0", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
        }))
        window?.rootViewController?.present(quantityAlertController, animated: true, completion: nil)
    }
}


extension ShoppingListCell: ListBindable {
    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? FridgeItemViewModel else { return }
        shoppingItem = viewModel
        // Retrive name
        nameLabel.text = viewModel.name
        // Retrive category image
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
        // Retrive need
        if viewModel.need != nil {
            if floor(viewModel.need!) == viewModel.need! {
                needLabel.text = String(Int(viewModel.need!))
            } else { needLabel.text = String(viewModel.need!) }
        } else { needLabel.text = "" }
    }
}
