//
//  PPSettingMoveToShoppingListLabel.swift
//  Fridge Helper
//
//  Created by Penn on 23/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPSettingHideItemLabel: UILabel {

    init() {
        super.init(frame: .zero)
        frame = CGRect.PPSettingLabelFrame
        frame.origin.y = CGFloat.PPSettingHideItemLabelPositionY
        frame.size.width *= 0.666
        textAlignment = .left
        backgroundColor = .clear
        font = UIFont.boldSystemFont(ofSize: CGFloat.PPSettingLabelFontSize)
        adjustsFontSizeToFitWidth = false
        lineBreakMode = .byTruncatingTail
        numberOfLines = 2
        text = "Hide items added to shopping list"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
