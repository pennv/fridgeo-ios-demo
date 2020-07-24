//
//  PPPurchaseViewControllerMonthBuyButton.swift
//  Fridgeo
//
//  Created by Penn on 28/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPPurchaseViewControllerMonthBuyButton: PPLoginButton {

    override init() {
        super.init()
        frame = CGRect.PPPurchaseViewControllerBuyButtonFrame
        setTitle("Monthly Plan      /Month", for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
