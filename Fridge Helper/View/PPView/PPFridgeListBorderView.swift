//
//  PPFridgeListBorderView.swift
//  Fridge Helper
//
//  Created by Penn on 1/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPFridgeListBorderView: UIView {
    
    init() {
        super.init(frame: .zero)
        self.frame = CGRect.PPFridgeListBorderViewFrame
        self.roundCorners(topLeft: 0, topRight: CGFloat.PPFridgeListBorderViewCornerRadius, bottomLeft: 0, bottomRight: CGFloat.PPFridgeListBorderViewCornerRadius)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeColor(_ color: UIColor) {
        self.backgroundColor = color
    }
}
