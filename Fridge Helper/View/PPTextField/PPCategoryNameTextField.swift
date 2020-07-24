//
//  PPCategoryNameTextField.swift
//  Fridge Helper
//
//  Created by Penn on 19/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPCategoryNameTextField: UITextField {

    init() {
        super.init(frame: .zero)
        frame = CGRect.PPCategoryNameTextFieldFrame
        placeholder = "Category Name"
        borderStyle = .none
        layer.addBorder(edge: .bottom, color: .gray, thickness: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
