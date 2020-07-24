//
//  PPNavigationViewController.swift
//  Fridge Helper
//
//  Created by Penn on 7/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = false
        navigationBar.shadowImage = UIImage()  // Hide navbar border
        self.onThemeChanged()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        // Switch theme
        self.onThemeChanged()
    }
    
    func onThemeChanged() {
        if traitCollection.userInterfaceStyle == .light {
            navigationBar.barTintColor = UIColor.Background.light
        } else {
            navigationBar.barTintColor = UIColor.Background.dark
        }
    }
}
