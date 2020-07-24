//
//  PPFridgeItemListCellPlusImageView.swift
//  Fridge Helper
//
//  Created by Penn on 29/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPFridgeItemListCellPlusButton: PPButtonWithResizedImage {

    init() {
        super.init(imageName: "plus_fridgeItemListCell", imageSize: CGFloat.PPFridgeItemListCellPlusButtonImageSize)
        frame = CGRect.PPFridgeItemListCellPlusButtonFrame
        bringSubviewToFront(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
