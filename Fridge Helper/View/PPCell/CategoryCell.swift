//
//  CategoryCell.swift
//  Fridge Helper
//
//  Created by Penn on 16/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit
import IGListKit

class CategoryCell: UICollectionViewCell {
    
    var category: NSDictionary?
    
    let categoryNameLabel = PPCategoryCellNameLabel()
    let categoryImageView = PPCategoryCellImageView()
    let deleteButton = PPCategoryCellCloseButton()
    
    override func layoutSubviews() {
        // Name label
        self.addSubview(categoryNameLabel)
        // Icon image
        self.addSubview(categoryImageView)
        // Delete button
        self.deleteButton.addTarget(self, action: #selector(onDeleteButtonClicked), for: .touchUpInside)
        self.addSubview(deleteButton)
    }
    
    func renderCell(category: NSDictionary?) {
        self.category = category
        let categoryName = (category?.object(forKey: "name") as! String).capitalizingFirstLetter()
        categoryNameLabel.text = categoryName
        let imageName = category?.object(forKey: "image") as! String
        categoryImageView.image = UIImage(named: imageName)
    }
    
    @objc func onDeleteButtonClicked() {
        let userInfo = ["deletingCategory" : self.category]
        NotificationCenter.default.post(name: .categoryUpdated, object: self, userInfo: userInfo as [AnyHashable : Any])
    }
}
