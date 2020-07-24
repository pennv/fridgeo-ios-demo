//
//  TabBarViewController.swift
//  Fridge Helper
//
//  Created by Penn on 22/3/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class TabBarViewController: PPTabBarViewContoller {
    
    let navigatedFridgeListViewController = PPNavigationController()
    let navigatedShoppingListViewController = PPNavigationController()
    let navigatedProfileViewController = PPNavigationController()
    
    let fridgeListViewController = FridgeListViewController()
    let shoppingListViewController = ShoppingListViewController()
    let profileViewController = ProfileViewController()
    //let recipeViewController = RecipeViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fridgeListViewController.tabBarItem.image = UIImage.fridgeTabBarImage
        navigatedFridgeListViewController.viewControllers = [fridgeListViewController]

        shoppingListViewController.tabBarItem.image = UIImage.shoppingTabBarImage
        navigatedShoppingListViewController.viewControllers = [shoppingListViewController]

        profileViewController.tabBarItem.image = UIImage.profileTabBarImage
        navigatedProfileViewController.viewControllers = [profileViewController]
        
        //recipeViewController.tabBarItem.image = UIImage.recipeTabBarImage

        viewControllers = [navigatedFridgeListViewController, navigatedShoppingListViewController, /*recipeViewController,*/ navigatedProfileViewController]
        addViewControllers(viewControllers: viewControllers!)
        
        // Remove upper border of tab bar
        tabBar.clipsToBounds = true
    }
}
