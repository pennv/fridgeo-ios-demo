//
//  PPNotReachableLabel.swift
//  Fridge Helper
//
//  Created by Penn on 16/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPNotReachableLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect.PPNotReachableLabelFrame
        text = "Oooops......please check on your internet and try again..."
        textAlignment = .left
        font = UIFont().PPFont(size: 24)
        lineBreakMode = .byWordWrapping
        numberOfLines = 3
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
