//
//  PPCategoryCellNameLabel.swift
//  Fridge Helper
//
//  Created by Penn on 17/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPCategoryCellNameLabel: UILabel {

    init() {
        super.init(frame: .zero)
        frame = CGRect.PPCategoryCellNameLabelFrame
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 18)
        numberOfLines = 1
        lineBreakMode = .byTruncatingTail
        isUserInteractionEnabled = false
        layer.addBorder(edge: .left, color: .gray, thickness: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
