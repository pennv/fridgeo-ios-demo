//
//  PPFacebookLoginButtoon.swift
//  Fridge Helper
//
//  Created by Penn on 25/3/20.
//  Copyright © 2020 Penn. All rights reserved.
//
//  Style for size, position and title of PPFacebookLoginButton

import UIKit

class PPFacebookLoginButton: PPLoginButton {
    override init() {
        super.init()
        frame = CGRect.PPFacebookLoginButtonFrame
        setTitle("CONTINUE WITH FACEBOOK", for: .normal)
        setImage(UIImage.facebookLoginButtonImage, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
