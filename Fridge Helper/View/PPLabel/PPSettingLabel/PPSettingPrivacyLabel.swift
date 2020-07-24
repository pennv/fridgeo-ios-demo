//
//  PPSettingPrivacyLabel.swift
//  Fridgeo
//
//  Created by Penn on 2/7/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPSettingPrivacyLabel: UILabel {

    init() {
        super.init(frame: .zero)
        frame = CGRect.PPSettingLabelFrame
        frame.origin.y = CGFloat.PPSettingPrivacyLabelPositionY
        frame.size.width *= 0.666
        textAlignment = .left
        backgroundColor = .clear
        font = UIFont.boldSystemFont(ofSize: CGFloat.PPSettingLabelFontSize)
        lineBreakMode = .byTruncatingTail
        numberOfLines = 1
        isUserInteractionEnabled = true
        text = "Privacy"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
