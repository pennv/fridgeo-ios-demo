//
//  PPUsernameLabel.swift
//  Fridge Helper
//
//  Created by Penn on 9/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPUsernameLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect.PPUsernameLabelFrame
        textAlignment = .left
        font = UIFont().PPFont(size: 26)
        adjustsFontSizeToFitWidth = false
        lineBreakMode = .byTruncatingTail
        numberOfLines = 1
        isUserInteractionEnabled = false
        // Observer for login status change
        NotificationCenter.default.addObserver(self, selector: #selector(onLoginStatusChanged), name: .loginStatusChanged, object: nil)
        // Initial load
        self.onLoginStatusChanged()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onLoginStatusChanged() {
        let userProfile = UserDefaults.standard.dictionary(forKey: Key.userProfile) as NSDictionary?
        if userProfile != nil {
            let username = userProfile!.object(forKey: "name") as! String
            self.text = username
        }
    }
}
