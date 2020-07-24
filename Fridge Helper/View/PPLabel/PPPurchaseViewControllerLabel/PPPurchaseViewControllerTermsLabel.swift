//
//  PPPurchaseViewControllerTermsLabel.swift
//  Fridgeo
//
//  Created by Penn on 28/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPPurchaseViewControllerTermsLabel: UITextView {

    init() {
        super.init(frame: CGRect.PPPurchaseViewControllerTermsLabelFrame, textContainer: .none)
        textAlignment = .justified
        let part1 = NSAttributedString(string: "Fridgeo Pro is the premium membership program of the Fridgeo app that allows you to store up to 1000 fridge items on the cloud (you can only store 10 fridge items in free tier).\nYour Frigeo Pro membership starts as soon as you setup payment and subscribe with iTunes. Your monthly or yearly charge will occur on the last day of the current billing period. We will renew your memebership for you (unless auto renew is turned-off 24 hours before the end of your billing cycle). Once your purchase is successful, you can manage your subscription or turn off auto-renewal under Account Settings. By continuing, you are agreeing to ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .light), NSAttributedString.Key.foregroundColor: UIColor.gray])
        let part2 = NSAttributedString(string: "Terms of Use", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .regular), NSAttributedString.Key.link: URL(string: "https://fridgeo.blogspot.com/2020/07/fridgeo-terms-and-conditions-by.html")!, NSAttributedString.Key.foregroundColor: UIColor.gray])
        let part3 = NSAttributedString(string: " and ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.gray])
        let part4 = NSAttributedString(string: "Privacy", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.link: URL(string: "https://fridgeo.blogspot.com/2020/07/fridgeo-privacy-policy.html")!])
        let content = NSMutableAttributedString(attributedString: part1)
        content.append(part2)
        content.append(part3)
        content.append(part4)
        attributedText = content
        isEditable = false
        dataDetectorTypes = .link
        onThemeChanged()
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
            self.backgroundColor = UIColor.PPTextView.PPProfilePopupWindowContenTextViewBackgroundColor.light
        } else {
            self.backgroundColor = UIColor.PPTextView.PPProfilePopupWindowContenTextViewBackgroundColor.dark        }
    }
}
