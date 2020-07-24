//
//  PPBackButtomImageView.swift
//  Fridge Helper
//
//  Created by Penn on 19/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPCategoryBackButton: PPButtonWithResizedImage {

    init() {
        super.init(imageName: "back", imageSize: CGFloat.PPPopupWindowViewTopLeftCornerButtonImageSize*0.9)
        self.frame = CGRect.PPPopupWindowViewTopLeftCornerButtonFrame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
