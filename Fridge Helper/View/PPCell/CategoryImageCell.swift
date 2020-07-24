//
//  CategoryImageCell.swift
//  Fridge Helper
//
//  Created by Penn on 19/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit
import IGListKit

class CategoryImageCell: UICollectionViewCell {

    var categoryImage = UIImageView()
    
    override func layoutSubviews() {
        categoryImage.frame = contentView.frame
        addSubview(categoryImage)
    }
    
    func renderCell(categoryImageName: String?) {
        self.categoryImage.image = UIImage(named: categoryImageName!)
    }
}
