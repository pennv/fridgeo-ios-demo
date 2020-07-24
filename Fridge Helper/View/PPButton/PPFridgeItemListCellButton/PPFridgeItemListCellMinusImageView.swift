//
//  PPFridgeItemListCellMinusImageView.swift
//  Fridge Helper
//
//  Created by Penn on 29/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPFridgeItemListCellMinusButton: PPButtonWithResizedImage {

    init() {
        super.init(imageName: "minus_fridgeItemListCell", imageSize: CGFloat.PPFridgeItemListCellMinusButtonImageSize)
        frame = CGRect.PPFridgeItemListCellMinusButtonFrame
        bringSubviewToFront(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
