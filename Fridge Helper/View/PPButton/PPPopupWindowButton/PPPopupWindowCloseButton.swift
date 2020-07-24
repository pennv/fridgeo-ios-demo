//
//  PPPopupWindowCloseButton.swift
//  Fridge Helper
//
//  Created by Penn on 20/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPPopupWindowCloseButton: PPButtonWithResizedImage {

    init() {
        super.init(imageName: "close", imageSize: CGFloat.PPPopupWindowViewTopLeftCornerButtonImageSize*0.8)
        self.frame = CGRect.PPPopupWindowViewTopLeftCornerButtonFrame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
