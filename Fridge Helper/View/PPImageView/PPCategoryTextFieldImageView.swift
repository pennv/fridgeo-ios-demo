//
//  PPCategoryTextFieldImageView.swift
//  Fridge Helper
//
//  Created by Penn on 19/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPCategoryTextFieldImageView: UIImageView {

    init() {
        super.init(frame: .zero)
        self.layer.masksToBounds = true
        self.frame = CGRect.PPCategoryTextFieldImageViewFrame
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = false
        self.image = UIImage(named: "category_meat")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
