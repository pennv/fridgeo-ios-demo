//
//  PPProfilePopupWindowSubtitleLabel.swift
//  Fridge Helper
//
//  Created by Penn on 24/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPProfilePopupWindowSubtitleLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 14)
        frame = CGRect.PPProfilePopupWindowSubtitleLabelFrame
        numberOfLines = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
