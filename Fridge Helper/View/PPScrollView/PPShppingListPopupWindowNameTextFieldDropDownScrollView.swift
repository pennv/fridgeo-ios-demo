//
//  PPShppingListPopupWindowNameTextFieldDropDownView.swift
//  Fridge Helper
//
//  Created by Penn on 21/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPShppingListPopupWindowNameTextFieldDropDownScrollView: UIScrollView {
    
    init() {
        super.init(frame: .zero)
        layer.masksToBounds = true
        frame = CGRect.PPShppingListPopupWindowNameTextFieldDropDownScrollViewFrame
        isHidden = true
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
            backgroundColor = UIColor.Background.light
        } else {
            backgroundColor = UIColor.Background.dark
        }
    }
}
