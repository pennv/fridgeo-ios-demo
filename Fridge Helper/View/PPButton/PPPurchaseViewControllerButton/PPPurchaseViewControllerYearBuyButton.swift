//
//  PPPurchaseViewControllerYearBuyButton.swift
//  Fridgeo
//
//  Created by Penn on 28/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPPurchaseViewControllerYearBuyButton: PPLoginButton {

    override init() {
        super.init()
        frame = CGRect.PPPurchaseViewControllerBuyButtonFrame
        frame.origin.y = CGFloat.PPPurchaseViewControllerYearBuyButtonPositionY
        setTitle("Annual Plan      /Month", for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
