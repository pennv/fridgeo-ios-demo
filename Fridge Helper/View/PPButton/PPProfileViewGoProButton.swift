//
//  PPProfileViewGoProButton.swift
//  Fridgeo
//
//  Created by Penn on 2/7/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPProfileViewGoProButton: PPButton {

    override init() {
        super.init()
        frame = CGRect.PPProfileViewGoProButtonFrame
        imageEdgeInsets = UIEdgeInsets.PPProfileViewGoProButtonImageInsets
        setTitle("Go Pro", for: .normal)
        layer.cornerRadius = CGFloat.PPProfileViewGoProButtonHeight/2
        setImage(UIImage.crown, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func onThemeChanged() {
        super.onThemeChanged()
        if traitCollection.userInterfaceStyle == .light {
            backgroundColor = UIColor.PPCell.CalendarDayCellBackgroundColor.light
        } else {
            backgroundColor = UIColor.PPCell.CalendarDayCellBackgroundColor.dark
        }
        layer.borderColor = backgroundColor?.cgColor
    }
}
