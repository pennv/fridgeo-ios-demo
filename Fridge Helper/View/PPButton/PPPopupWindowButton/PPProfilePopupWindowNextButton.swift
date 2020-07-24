//
//  PPProfilePopupWindowNextButton.swift
//  Fridge Helper
//
//  Created by Penn on 25/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPProfilePopupWindowNextButton: PPButton {

    override init() {
        super.init()
        frame = CGRect.PPProfilePopupWindowNextButtonFrame
        titleLabel?.font = UIFont().PPFont(size: CGFloat.PPProfilePopupWindowButtonFontSize)
        setTitle("→", for: .normal)
        layer.cornerRadius = CGFloat.PPProfilePopupWindowButtonCornerRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
