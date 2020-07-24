//
//  PPPopupBackgroundView.swift
//  Fridge Helper
//
//  Created by Penn on 23/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//
/*
    This view contains the transparent background of
    popup view covering whole screen, also the popup
    window which will be passed as parameter will be
    attached onto it.
*/

import UIKit

class PPPopupView: UIView {
    
    var popupWindow: UIView?
    
    init(popupWindowView: UIView) {
        super.init(frame: .zero)
        self.popupWindow = popupWindowView
        self.frame = CGRect.PPPopupViewFrame
        self.addSubview(self.popupWindow!)
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
        self.alpha = 0
        if traitCollection.userInterfaceStyle == .light {
            self.backgroundColor = UIColor.PPView.PPPopupViewBackgroundColor.light
        } else {
            self.backgroundColor = UIColor.PPView.PPPopupViewBackgroundColor.dark
        }
        UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {
            self.alpha = 1
        })
    }
}
