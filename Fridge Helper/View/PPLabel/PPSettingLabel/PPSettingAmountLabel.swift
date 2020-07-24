//
//  PPSettingAmountLabel.swift
//  Fridge Helper
//
//  Created by Penn on 23/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPSettingAmountLabel: UILabel {

    init() {
        super.init(frame: .zero)
        frame = CGRect.PPSettingLabelFrame
        textAlignment = .left
        backgroundColor = .clear
        font = UIFont.boldSystemFont(ofSize: CGFloat.PPSettingLabelFontSize)
        adjustsFontSizeToFitWidth = false
        lineBreakMode = .byTruncatingTail
        numberOfLines = 1
        isUserInteractionEnabled = true
        text = "Tap to set +/- amount"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
