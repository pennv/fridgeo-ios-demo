//
//  PPShoppingListCountLabel.swift
//  Fridge Helper
//
//  Created by Penn on 17/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPShoppingListCountLabel: UILabel {
    
    let title = NSAttributedString(string: "\nShopping", attributes: [NSAttributedString.Key.font: UIFont().PPFont(size: 13), NSAttributedString.Key.foregroundColor: UIColor.PPLabel.PPCountLabel.title!])
    
    init() {
        super.init(frame: .zero)
            frame = CGRect.PPShoppingListCountLabelFrame
            textAlignment = .center
            numberOfLines = 2
            layer.addBorder(edge: UIRectEdge.top, color: UIColor.PPLabel.PPCountLabel.border.light!, thickness: 0.5)
            // Change border color based on theme
            self.onThemeChanged()
            // Observer for data updated
            NotificationCenter.default.addObserver(self, selector: #selector(onDataUpdated(_:)), name: .dataUpdated, object: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            // Switch theme
            self.onThemeChanged()
        }
        
                @objc func onDataUpdated(_ notification: Notification) {
            // Update or recover fridge item list
            let fridgeItemList = notification.userInfo!["fridgeItemList"]
            var shoppingCount = 0
            if fridgeItemList != nil {
                for item in fridgeItemList as! [NSDictionary] {
                    if item.object(forKey: "list") as? Double == 1 {
                        shoppingCount += 1
                    }
                }
                let fridgeItemCount = NSAttributedString(string: String(shoppingCount), attributes: [NSAttributedString.Key.font: UIFont().PPFont(size: 16)])
                let content = NSMutableAttributedString(attributedString: fridgeItemCount)
                content.append(title)
                self.attributedText = content
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
