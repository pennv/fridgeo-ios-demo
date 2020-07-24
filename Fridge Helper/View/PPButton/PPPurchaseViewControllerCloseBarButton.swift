//
//  PPPurchaseViewControllerCloseBarButton.swift
//  Fridgeo
//
//  Created by Penn on 28/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPPurchaseViewControllerCloseBarButton: PPButtonWithResizedImage {

    init() {
        super.init(imageName: "close", imageSize: CGFloat.PPSettingBarButtonImageSize*0.7)
        setImage(UIImage(named: "close")?.resizeImage(to: CGFloat.PPSettingBarButtonImageSize*0.7), for: .normal)
        frame = CGRect.PPBarButtonFrame
        imageView?.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
