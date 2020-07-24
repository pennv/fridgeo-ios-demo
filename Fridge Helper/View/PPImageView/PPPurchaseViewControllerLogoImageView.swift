//
//  PPPurchaseViewControllerLogoImageView.swift
//  Fridgeo
//
//  Created by Penn on 28/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPPurchaseViewControllerLogoImageView: UIImageView {

    init() {
        super.init(frame: CGRect())
        layer.masksToBounds = true
        layer.borderColor = UIColor(red: 0.98, green: 0.84, blue: 0.34, alpha: 1.00).cgColor
        layer.borderWidth = 4
        frame = CGRect.PPPurchaseViewControllerLogoImageViewFrame
        layer.cornerRadius = CGFloat.PPPurchaseViewControllerLogoImageViewHeight/2
        isUserInteractionEnabled = false
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
            image = UIImage.blackLogo
        } else {
            image = UIImage.logo
        }
    }
}
