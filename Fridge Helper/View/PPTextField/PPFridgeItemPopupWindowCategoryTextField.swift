//
//  PPFridgeItemPopupWindowCategoryTextField.swift
//  Fridge Helper
//
//  Created by Penn on 29/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPFridgeItemPopupWindowCategoryTextField: UITextField {

    init() {
        super.init(frame: .zero)
        frame = CGRect.PPFridgeItemPopupWindowTextFieldFrame
        frame.origin.y = CGFloat.PPFridgeItemPopupWindowCategoryTextFieldPositionY
        font = UIFont.boldSystemFont(ofSize: 18)
        placeholder = "Tap to select category"
        borderStyle = .none
        //layer.addBorder(edge: .bottom, color: .gray, thickness: 0.6)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
