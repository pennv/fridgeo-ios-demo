//
//  PPBarButton.swift
//  Fridge Helper
//
//  Created by Penn on 6/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPProfileSettingBarButton: PPButtonWithResizedImage {
    
    init() {
        super.init(imageName: "setting_profile", imageSize: CGFloat.PPSettingBarButtonImageSize)
        setImage(UIImage(named: "setting_profile")?.resizeImage(to: CGFloat.PPSettingBarButtonImageSize), for: .normal)
        frame = CGRect.PPBarButtonFrame
        imageView?.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
