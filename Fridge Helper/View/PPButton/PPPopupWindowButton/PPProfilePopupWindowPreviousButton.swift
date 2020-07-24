//
//  PPProfilePopupWindowPreviousButton.swift
//  Fridge Helper
//
//  Created by Penn on 24/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPProfilePopupWindowPreviousButton: PPButton {
    
    override init() {
        super.init()
        frame = CGRect.PPProfilePopupWindowPreviousButtonFrame
        titleLabel?.font = UIFont().PPFont(size: CGFloat.PPProfilePopupWindowButtonFontSize)
        setTitle("←", for: .normal)
        layer.cornerRadius = CGFloat.PPProfilePopupWindowButtonCornerRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
