//
//  PPFridgeItemPopupWindowQuantityTextField.swift
//  Fridge Helper
//
//  Created by Penn on 29/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPFridgeItemPopupWindowQuantityTextField: UITextField {

    init() {
        super.init(frame: .zero)
        frame = CGRect.PPFridgeItemPopupWindowTextFieldFrame
        frame.origin.y = CGFloat.PPFridgeItemPopupWindowQuantityTextFieldPositionY
        font = UIFont.boldSystemFont(ofSize: 18)
        placeholder = "Tap to set quantity"
        borderStyle = .none
        keyboardType = .decimalPad
        clearButtonMode = .whileEditing
        //layer.addBorder(edge: .bottom, color: .gray, thickness: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
