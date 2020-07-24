//
//  PPSettingTermsLabel.swift
//  Fridgeo
//
//  Created by Penn on 2/7/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPSettingTermsLabel: UILabel {

    init() {
        super.init(frame: .zero)
        frame = CGRect.PPSettingLabelFrame
        frame.origin.y = CGFloat.PPSettingTermsLabelPositionY
        frame.size.width *= 0.666
        textAlignment = .left
        backgroundColor = .clear
        font = UIFont.boldSystemFont(ofSize: CGFloat.PPSettingLabelFontSize)
        lineBreakMode = .byTruncatingTail
        numberOfLines = 1
        isUserInteractionEnabled = true
        text = "Terms & Conditions"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
