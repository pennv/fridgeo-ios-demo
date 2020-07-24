//
//  PPFridgeItemPopupWindowTextField.swift
//  Fridge Helper
//
//  Created by Penn on 28/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPFridgeItemPopupWindowNameTextField: UITextField {

    init() {
        super.init(frame: .zero)
        frame = CGRect.PPFridgeItemPopupWindowTextFieldFrame
        font = UIFont.boldSystemFont(ofSize: 18)
        placeholder = "Tap to set name"
        borderStyle = .none
        clearButtonMode = .whileEditing
        //layer.addBorder(edge: .left, color: .gray, thickness: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
