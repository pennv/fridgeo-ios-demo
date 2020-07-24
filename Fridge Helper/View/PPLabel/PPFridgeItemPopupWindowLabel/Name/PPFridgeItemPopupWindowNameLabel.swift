//
//  PPFridgeItemPopupWindowNameLabel.swift
//  Fridge Helper
//
//  Created by Penn on 28/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPFridgeItemPopupWindowNameLabel: UILabel {

    init() {
        super.init(frame: .zero)
        frame = CGRect.PPPPFridgeItemPopupWindowNameLabelFrame
        text = "Name*"
        textAlignment = .left
        font = UIFont.systemFont(ofSize: 14)
        lineBreakMode = .byWordWrapping
        numberOfLines = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
