//
//  PPTabBarViewContoller.swift
//  Fridge Helper
//
//  Created by Penn on 25/3/20.
//  Copyright © 2020 Penn. All rights reserved.
//
//  The PPTabBarViewContoller will handle the
//  switch between dark and light theme and
//  setup image edge insets for all controllers.
//

import UIKit

class PPTabBarViewContoller: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.onThemeChanged()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        // Switch theme
        self.onThemeChanged()
    }
    
    func onThemeChanged() {
        if traitCollection.userInterfaceStyle == .light {
            self.tabBar.barTintColor = UIColor.PPTabBar.tintColor.light
            self.tabBar.selectedImageTintColor = UIColor.PPTabBar.selectedImageTintColor.light
            self.tabBar.unselectedItemTintColor = UIColor.PPTabBar.unselectedItemTintColor.light
        } else {
            self.tabBar.barTintColor = UIColor.PPTabBar.tintColor.dark
            self.tabBar.selectedImageTintColor = UIColor.PPTabBar.selectedImageTintColor.dark
            self.tabBar.unselectedItemTintColor = UIColor.PPTabBar.unselectedItemTintColor.dark
        }
    }
    
    func addViewControllers(viewControllers: [UIViewController]) {
        for viewController in viewControllers {
            if type(of: viewController) == UINavigationController.self {
                let navigationController = viewController as! UINavigationController
                navigationController.viewControllers.first!.tabBarItem.imageInsets = UIEdgeInsets.PPTabBarImageInsets
            } else {
                viewController.tabBarItem.imageInsets = UIEdgeInsets.PPTabBarImageInsets
            }
        }
    }
}
