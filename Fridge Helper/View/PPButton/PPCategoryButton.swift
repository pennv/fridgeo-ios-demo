//
//  PPCategoryButton.swift
//  Fridge Helper
//
//  Created by Penn on 13/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//
/*  This button is able to adjust the width based
    on size of title (string) and color based on
    current theme.
 */

import UIKit

class PPCategoryScrollerButton: UIButton {
    
    var categoryName: String = ""
    var clickStatus: Bool = false
    
    init(_ categoryName: String) {
        super.init(frame: .zero)
        self.categoryName = categoryName
        setTitle(categoryName, for: .normal)
        sizeToFit() // Generate width based on size of title
        if frame.size.width < CGFloat.PPCategoryButtonMinimumWidth { frame.size.width = CGFloat.PPCategoryButtonMinimumWidth } // Set minimum width for a shorter category button
        frame.size.width *= CGFloat.PPCategoryButtonWidthFactor // Leave a bit white blank on sides of title string
        frame.size.height = CGFloat.PPCategoryButtonHeight
        titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat.PPCategoryButtonFontSize)
        if categoryName == "＋" { titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat.PPCategoryButtonFontSize*1.5) }
        layer.cornerRadius = CGFloat.PPCategoryButtonCornerRadius
        layer.borderWidth = 0
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
    
// Solution for changing button background
//    func onThemeChanged() {
//        if clickStatus {
//            if traitCollection.userInterfaceStyle == .light {
//                self.backgroundColor = UIColor.Background.dark
//                setTitleColor(UIColor.PPButton.fontColor.dark, for: .normal)
//            } else {
//                self.backgroundColor = UIColor.Background.light
//                setTitleColor(UIColor.PPButton.fontColor.light, for: .normal)
//            }
//        } else {
//            if traitCollection.userInterfaceStyle == .light {
//                self.backgroundColor = UIColor.Background.light
//            } else {
//                self.backgroundColor = UIColor.Background.dark
//            }
//            setTitleColor(UIColor.PPButton.PPCategoryButtonFontColor, for: .normal)
//        }
//    }
    
    func onThemeChanged() {
        if clickStatus {
            if traitCollection.userInterfaceStyle == .light {
                self.backgroundColor = UIColor.Background.light
                layer.addBorder(edge: .bottom, color: UIColor.Background.dark, thickness: 2)
                setTitleColor(UIColor.PPButton.fontColor.light, for: .normal)
            } else {
                self.backgroundColor = UIColor.Background.dark
                layer.addBorder(edge: .bottom, color: UIColor.Background.light!, thickness: 2)
                setTitleColor(UIColor.PPButton.fontColor.dark, for: .normal)
            }
        } else {
            if traitCollection.userInterfaceStyle == .light {
                self.backgroundColor = UIColor.Background.light
                layer.addBorder(edge: .bottom, color: UIColor.Background.light!, thickness: 2)
            } else {
                self.backgroundColor = UIColor.Background.dark
                layer.addBorder(edge: .bottom, color: UIColor.Background.dark, thickness: 2)
            }
            setTitleColor(UIColor.PPButton.PPCategoryButtonFontColor, for: .normal)
        }
    }
    
    func getCategoryName() -> String {
        return self.categoryName
    }
    
    func setClickStatus(_ status: Bool) {
        self.clickStatus = status
        self.onThemeChanged()
    }
}
