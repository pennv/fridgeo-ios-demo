//
//  PPFridgeItemListCellCategoryLabel.swift
//  Fridge Helper
//
//  Created by Penn on 27/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPFridgeItemListCellCategoryLabel: UILabel {

    init() {
        super.init(frame: .zero)
        self.frame = CGRect.PPFridgeItemListCellCategoryLabelFrame
        textAlignment = .left
        backgroundColor = .clear
        font = .systemFont(ofSize: 13)
        adjustsFontSizeToFitWidth = false
        lineBreakMode = .byTruncatingTail
        numberOfLines = 1
        isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
