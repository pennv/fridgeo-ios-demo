//
//  PPFridgeItemListCellImageView.swift
//  Fridge Helper
//
//  Created by Penn on 27/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPFridgeItemListCellCategoryImageView: UIImageView {

    init() {
        super.init(frame: CGRect())
        self.layer.masksToBounds = true
        self.frame = CGRect.PPFridgeItemListCellCategoryImageViewFrame
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = false
        self.image = UIImage(named: "category_meat")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
