//
//  PPPurchaseViewControllerRestoreLabel.swift
//  Fridgeo
//
//  Created by Penn on 7/7/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPPurchaseViewControllerRestoreLabel: UILabel {

    init() {
        super.init(frame: .zero)
        frame = CGRect.PPPurchaseViewControllerRestoreLabelFrame
        textAlignment = .center
        text = "Restore"
        isUserInteractionEnabled = true
        font = UIFont.systemFont(ofSize: 12, weight: .light)
        textColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
