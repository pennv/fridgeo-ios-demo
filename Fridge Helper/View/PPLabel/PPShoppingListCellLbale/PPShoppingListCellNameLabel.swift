//
//  PPShoppingListCellNameLabel.swift
//  Fridge Helper
//
//  Created by Penn on 19/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPShoppingListCellNameLabel: UILabel {

    init() {
        super.init(frame: .zero)
        self.frame = CGRect.PPShoppingListCellNameLabelFrame
        textAlignment = .left
        backgroundColor = .clear
        font = UIFont.boldSystemFont(ofSize: 17)
        adjustsFontSizeToFitWidth = false
        lineBreakMode = .byTruncatingTail
        numberOfLines = 1
        isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
