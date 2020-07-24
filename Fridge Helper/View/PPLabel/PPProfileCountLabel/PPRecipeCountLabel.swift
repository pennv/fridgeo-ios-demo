//
//  PPRecipeCountLabel.swift
//  Fridge Helper
//
//  Created by Penn on 17/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPRecipeCountLabel: UILabel {

    let title = NSAttributedString(string: "\nCategory", attributes: [NSAttributedString.Key.font: UIFont().PPFont(size: 13), NSAttributedString.Key.foregroundColor: UIColor.PPLabel.PPCountLabel.title!])

    init() {
        super.init(frame: .zero)
        frame = CGRect.PPRecipeCountLabelFrame
        textAlignment = .center
        numberOfLines = 2
        layer.addBorder(edge: UIRectEdge.top, color: UIColor.PPLabel.PPCountLabel.border.light!, thickness: 0.5)
        // Change border color based on theme
        onThemeChanged()
        // Load category count
        loadCategroyCount()
        // Observer for data updated
        NotificationCenter.default.addObserver(self, selector: #selector(onUserUpdated(_:)), name: .userUpdated, object: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        // Switch theme
        onThemeChanged()
    }
    
    func loadCategroyCount() {
        let userProfile = UserDefaults.standard.dictionary(forKey: Key.userProfile)! as NSDictionary
        let categoryList = userProfile.object(forKey: "category") as! [NSDictionary]
        let categoryCount = NSAttributedString(string: String(categoryList.count), attributes: [NSAttributedString.Key.font: UIFont().PPFont(size: 16)])
        let content = NSMutableAttributedString(attributedString: categoryCount)
        content.append(title)
        attributedText = content
    }
    
    @objc func onUserUpdated(_ notification: Notification) {
        // Update or recover fridge item list
        if let categoryList = notification.userInfo!["categoryList"] as? [NSDictionary] {
            let categoryCount = NSAttributedString(string: String(categoryList.count), attributes: [NSAttributedString.Key.font: UIFont().PPFont(size: 16)])
            let content = NSMutableAttributedString(attributedString: categoryCount)
            content.append(title)
            attributedText = content
        }
    }
    
    func onThemeChanged() {
        if self.traitCollection.userInterfaceStyle == .light {
            self.layer.addBorder(edge: UIRectEdge.top, color: UIColor.PPLabel.PPCountLabel.border.light!, thickness: 0.5)
        } else {
            self.layer.addBorder(edge: UIRectEdge.top, color: UIColor.PPLabel.PPCountLabel.border.dark!, thickness: 0.5)
        }
    }
}
