//
//  PPFridgeItemPopupWindowQuantityWarningLabel.swift
//  Fridge Helper
//
//  Created by Penn on 29/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPFridgeItemPopupWindowQuantityWarningLabel: UILabel {

    init() {
        super.init(frame: .zero)
        textAlignment = .left
        font = UIFont.systemFont(ofSize: 10)
        textColor = .red
        frame = CGRect.PPFridgeItemPopupWindowNameWarningLabelFrame
        frame.origin.y = CGFloat.PPFridgeItemPopupWindowQuantityWarningLabelPositionY
        numberOfLines = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
