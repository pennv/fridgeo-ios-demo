//
//  PPScannerCloseButton.swift
//  Fridge Helper
//
//  Created by Penn on 9/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPScannerCloseButton: PPButtonWithResizedImage {

    init() {
        super.init(imageName: "close_circle_filled", imageSize: CGFloat.PPScannerCloseButtonImageSize)
        frame = CGRect.PPScannerCloseButtonFrame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
