//
//  PPCategoryCellImageView.swift
//  Fridge Helper
//
//  Created by Penn on 17/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPCategoryCellImageView: UIImageView {

    init() {
        super.init(frame: CGRect())
        self.layer.masksToBounds = true
        self.frame = CGRect.PPCategoryCellImageViewFrame
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
