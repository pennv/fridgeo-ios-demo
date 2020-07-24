//
//  PPPopupWindowView.swift
//  Fridge Helper
//
//  Created by Penn on 24/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//
/*
    This view is the template for all popup windows
    which are attached onto the PPPopupView (background)
*/

import UIKit

class PPPopupWindowView: UIView {
    
    let closeButton = PPPopupWindowCloseButton()

    init() {
        super.init(frame: .zero)
        layer.cornerRadius = CGFloat.PPPopupWindowViewCornerRadius
        layer.shadowOpacity = CGFloat.PPPopupWindowViewShadowOpacity
        // Configure close button
        frame = CGRect.PPPopupWindowViewFrame
        closeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCloseButtonClicked)))
        addSubview(closeButton)
        self.onThemeChanged()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.frame.origin.x = -CGFloat.PPPopupWindowViewWidth
        self.alpha = 0
        // Ease in category editing popup window
        UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {
            self.frame.origin.x = CGFloat.PPPopupWindowViewPositionX
            self.alpha = 1
        })
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        // Switch theme
        self.onThemeChanged()
    }
    
    func onThemeChanged() {
        if traitCollection.userInterfaceStyle == .light {
            self.backgroundColor = UIColor.PPView.PPPopupWindowBackgroundColor.light
            layer.shadowColor = UIColor.PPView.PPPopupViewBackgroundColor.dark.cgColor
        } else {
            self.backgroundColor = UIColor.PPView.PPPopupWindowBackgroundColor.dark
            layer.shadowColor = UIColor.PPView.PPPopupViewBackgroundColor.light?.cgColor
        }
    }
    
    @objc func onCloseButtonClicked() {
        // Ease out category popup
        UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {
            self.frame.origin.x = -CGFloat.PPPopupWindowViewWidth
            self.alpha = 0
            // Ease out popup background (popup's superview)
            self.superview?.alpha = 0
        }, completion: { _ in
            self.frame.origin.x = CGFloat.PPPopupWindowViewPositionX
            // Remove superview (including popup itself)
            self.superview?.removeFromSuperview()
        })
    }
}
