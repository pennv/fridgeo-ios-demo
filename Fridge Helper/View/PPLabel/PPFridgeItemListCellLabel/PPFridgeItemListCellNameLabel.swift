//
//  PPFridgeItemListCellNameLabel.swift
//  Fridge Helper
//
//  Created by Penn on 27/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPFridgeItemListCellNameLabel: UILabel {

    init() {
        super.init(frame: .zero)
        self.frame = CGRect.PPFridgeItemListCellNameLabelFrame
        textAlignment = .left
        backgroundColor = .clear
        font = UIFont().PPFont(size: 17)
        adjustsFontSizeToFitWidth = false
        lineBreakMode = .byTruncatingTail
        numberOfLines = 1
        isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
