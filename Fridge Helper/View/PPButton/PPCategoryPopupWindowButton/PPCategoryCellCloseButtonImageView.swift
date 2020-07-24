//
//  PPCategoryCellCloseButtonImageView.swift
//  Fridge Helper
//
//  Created by Penn on 17/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPCategoryCellCloseButton: PPButtonWithResizedImage {

    init() {
        super.init(imageName: "close_circle", imageSize: CGFloat.PPCloseBarButtonImageSize)
        self.frame = CGRect.PPCategoryCellCloseButtonFrame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
