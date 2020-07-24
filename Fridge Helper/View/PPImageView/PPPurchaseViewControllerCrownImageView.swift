//
//  PPPurchaseViewControllerCrownImageView.swift
//  Fridgeo
//
//  Created by Penn on 28/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPPurchaseViewControllerCrownImageView: UIImageView {

    init() {
        super.init(frame: CGRect())
        frame = CGRect.PPPurchaseViewControllerCrownImageViewFrame
        isUserInteractionEnabled = false
        image = UIImage.crown
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
