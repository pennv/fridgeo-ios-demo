//
//  PPProfilePopupWindowTitleLabel.swift
//  Fridge Helper
//
//  Created by Penn on 24/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPProfilePopupWindowTitleLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        textAlignment = .center
        font = UIFont().PPFont(size: 22)
        frame = CGRect.PPProfilePopupWindowTitleLabelFrame
        numberOfLines = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
