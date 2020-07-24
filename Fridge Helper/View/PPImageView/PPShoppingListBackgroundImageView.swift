//
//  PPShoppingListBackgroundImageView.swift
//  Fridgeo
//
//  Created by Penn on 3/7/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPShoppingListBackgroundImageView: UIImageView {

    init() {
        super.init(frame: .zero)
        frame = CGRect.PPFridgeListBackgroundImageViewFrame
        isUserInteractionEnabled = true
        image = UIImage(named: "cart_background")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
