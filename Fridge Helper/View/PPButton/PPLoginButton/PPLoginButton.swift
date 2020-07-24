//
//  PPLoginButton.swift
//  Fridge Helper
//
//  Created by Penn on 25/3/20.
//  Copyright © 2020 Penn. All rights reserved.
//
//  Style for all PPLoginButtons, including
//  image edge insets, background color,
//  title color and border color, and handle
//  the switch between themes.
//

import UIKit

class PPLoginButton: PPButton {
    override init() {
        super.init()
        self.imageEdgeInsets = UIEdgeInsets.PPLoginButtonImageInsets
        self.layer.cornerRadius = CGFloat.PPLoginButtonCornerRadius
        self.onThemeChanged()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        // Switch theme
        self.onThemeChanged()
    }
}
