//
//  PPGoogleLoginButton.swift
//  Fridge Helper
//
//  Created by Penn on 25/3/20.
//  Copyright © 2020 Penn. All rights reserved.
//
//  Style for size, postion and title for PPGoogleLoginButton
//

import UIKit

class PPGoogleLoginButton: PPLoginButton {
    override init() {
        super.init()
        frame = CGRect.PPGoogleLoginButtonFrame
        setTitle("CONTINUE WITH GOOGLE", for: .normal)
        setImage(UIImage.googleLoginButtonImage, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
