//
//  PPSloganLabel.swift
//  Fridge Helper
//
//  Created by Penn on 30/3/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPSloganLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect.PPSloganLabelFrame
        text = "Make your kitchen life easier."
        textAlignment = .left
        font = UIFont().PPFont(size: 38)
        lineBreakMode = .byWordWrapping
        numberOfLines = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
