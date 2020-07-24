//
//  PPAppleLoginButton.swift
//  Fridgeo
//
//  Created by Penn on 7/7/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPAppleLoginButton: PPLoginButton {

    override init() {
        super.init()
        frame = CGRect.PPAppleLoginButtonFrame
        setTitle("CONTINUE WITH APPLE", for: .normal)
        setImage(UIImage(named: "apple_loginButton"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
