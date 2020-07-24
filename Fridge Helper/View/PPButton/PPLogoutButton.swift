//
//  PPLogoutButton.swift
//  Fridge Helper
//
//  Created by Penn on 23/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPLogoutButton: PPButton {
    
    override init() {
        super.init()
        setTitle("Logout", for: .normal)
        frame = CGRect.PPLogoutButtonFrame
        layer.cornerRadius = CGFloat.PPLogoutButtonHeight/2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
