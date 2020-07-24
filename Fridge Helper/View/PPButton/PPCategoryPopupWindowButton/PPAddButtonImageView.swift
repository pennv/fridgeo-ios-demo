//
//  PPAddButtonImageView.swift
//  Fridge Helper
//
//  Created by Penn on 19/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPCategoryAddButton: PPButtonWithResizedImage {

    init() {
        super.init(imageName: "add", imageSize: CGFloat.PPPopupWindowViewTopRightCornerButtonImageSize)
        frame = CGRect.PPPopupWindowViewTopRightCornerButtonFrame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
