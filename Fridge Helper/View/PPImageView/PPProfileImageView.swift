//
//  PPUserProfileImageView.swift
//  Fridge Helper
//
//  Created by Penn on 8/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit
import Kingfisher

class PPUserProfileImageView: UIImageView {
    
    init() {
        super.init(frame: CGRect())
        self.layer.masksToBounds = true
        self.frame = CGRect.PPProfileImageViewFrame
        self.layer.cornerRadius = CGFloat.PPProfileImageViewCornerRadius
        self.isUserInteractionEnabled = false
        // Add observer for login status change
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
            // If user has logged in, load image from online or cache
            guard let urlString = userProfile!.object(forKey: "picture") as? String else {
                image = UIImage(named: "user_profile")
                return
            }
            let url = URL(string: urlString)
            //let processor = RoundCornerImageProcessor(cornerRadius: CGFloat.PPProfileImageViewCornerRadius)
            self.kf.indicatorType = .activity
            self.kf.setImage(with: url, options: [.transition(.fade(0.2))])
        }
    }
}
