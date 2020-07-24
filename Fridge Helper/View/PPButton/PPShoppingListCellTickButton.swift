
//
//  PPShoppingListCellTickButton.swift
//  Fridge Helper
//
//  Created by Penn on 19/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPShoppingListCellTickButton: PPButtonWithResizedImage {

    init() {
        super.init(imageName: "tick", imageSize: CGFloat.PPShoppingListCellTickButtonImageWidth)
        frame = CGRect.PPShoppingListCellTickButtonFrame
        bringSubviewToFront(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
