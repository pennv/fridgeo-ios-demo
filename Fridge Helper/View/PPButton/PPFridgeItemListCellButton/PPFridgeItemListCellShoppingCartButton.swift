//
//  PPFridgeItemListCellShoppingCartButton.swift
//  Fridge Helper
//
//  Created by Penn on 16/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPFridgeItemListCellShoppingCartButton: PPButtonWithResizedImage {

    init() {
        super.init(imageName: "shopping_fridgeItemListCell_filled", imageSize: CGFloat.PPFridgeItemListCellShoppingCartButtonImageSize)
        frame = CGRect.PPFridgeItemListCellShoppingCartButtonFrame
        bringSubviewToFront(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
