//
//  PPCategoryTextFieldWarningLabel.swift
//  Fridge Helper
//
//  Created by Penn on 19/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPCategoryTextFieldWarningLabel: UILabel {

    init() {
        super.init(frame: .zero)
        textAlignment = .left
        font = UIFont.systemFont(ofSize: 10)
        textColor = .red
        frame = CGRect.PPCategoryTextFieldWarningLabelFrame
        numberOfLines = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
