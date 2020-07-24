//
//  PPFridgeItemPopupWindowViewSaveButton.swift
//  Fridge Helper
//
//  Created by Penn on 29/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPFridgeItemPopupWindowViewSaveButton: PPButton {

    override init() {
        super.init()
        frame = CGRect.PPCategoryImageViewOKButtonFrame
        titleLabel?.font = UIFont.systemFont(ofSize: 17)
        setTitle("Save", for: .normal)
        layer.cornerRadius = CGFloat.PPProfilePopupWindowButtonCornerRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
