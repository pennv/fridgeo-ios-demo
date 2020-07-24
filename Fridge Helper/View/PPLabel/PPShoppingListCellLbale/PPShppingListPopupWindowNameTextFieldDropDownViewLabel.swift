//
//  PPShppingListPopupWindowNameTextFieldDropDownViewLabel.swift
//  Fridge Helper
//
//  Created by Penn on 21/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPShppingListPopupWindowNameTextFieldDropDownScrollViewLabel: UILabel {

    init() {
        super.init(frame: .zero)
        frame = CGRect.PPShppingListPopupWindowNameTextFieldDropDownScrollViewLabelFrame
        textAlignment = .left
        backgroundColor = .clear
        font = UIFont.boldSystemFont(ofSize: 17)
        adjustsFontSizeToFitWidth = false
        lineBreakMode = .byTruncatingTail
        numberOfLines = 1
        isUserInteractionEnabled = true
        onThemeChanged()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        // Switch theme
        onThemeChanged()
    }
    
    func onThemeChanged() {
        if traitCollection.userInterfaceStyle == .light {
            //layer.addBorder(edge: .bottom, color: UIColor.PPLabel.PPFridgeItemListCellLabel.border.light!, thickness: 0.8)
        } else {
            //layer.addBorder(edge: .bottom, color: UIColor.PPLabel.PPFridgeItemListCellLabel.border.dark!, thickness: 0.8)
        }
    }
}
