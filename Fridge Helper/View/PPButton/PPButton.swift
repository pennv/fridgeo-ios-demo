//
//  PPButton.swift
//  Fridge Helper
//
//  Created by Penn on 25/3/20.
//  Copyright © 2020 Penn. All rights reserved.
//
//  Style for all PPButtons, including border
//  width, corner radius and font size.
//

import UIKit

class PPButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        layer.borderWidth = CGFloat.PPButtonBorderWidth
        layer.borderColor = UIColor.PPButton.borderColor
        titleLabel?.font = UIFont().PPFont(size: CGFloat.PPButtonFontSize)
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
    
    func onThemeChanged() {
        if traitCollection.userInterfaceStyle == .light {
            self.setTitleColor(UIColor.PPButton.fontColor.light, for: .normal)
            self.backgroundColor = UIColor.PPButton.backgroundColor.light
        } else {
            self.setTitleColor(UIColor.PPButton.fontColor.dark, for: .normal)
            self.backgroundColor = UIColor.PPButton.backgroundColor.dark
        }
    }
}
