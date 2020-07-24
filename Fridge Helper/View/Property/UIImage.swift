//
//  UIImage.swift
//  Fridge Helper
//
//  Created by Penn on 30/3/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

extension UIImage {
    
    // Login button image on login view
    static let facebookLoginButtonImage = UIImage(named: "facebook_loginButton")
    static let googleLoginButtonImage  = UIImage(named: "google_loginButton")
    // Tab bar images
    static let fridgeTabBarImage = UIImage(named: "fridge_tabBar")
    static let recipeTabBarImage = UIImage(named: "recipe_tabBar")
    static let shoppingTabBarImage = UIImage(named: "shopping_tabBar")
    static let profileTabBarImage = UIImage(named: "profile_tabBar")
    // Bar button images
    static let settingProfileImage = UIImage(named: "setting_profile")
    // User profile image
    static let userProfileImageLight = (UIImage(named: "user_profile_light"))
    static let userProfileImageDark = (UIImage(named: "user_profile_dark"))
    // Close button
    static let closeButton = (UIImage(named: "close"))
    // Logo
    static let logo = (UIImage(named: "logo"))
    // Logo black
    static let blackLogo = (UIImage(named: "logo_black"))
    // Bucket image
    static let bucketImage = UIImage(named: "bucket")
    // Shopping cart image on fridgeItemListCell
    static let fridgeItemListCellShoppingCartImage = UIImage(named: "shopping_fridgeItemListCell")
    // Filled shopping cart image on fridgeItemListCell
    static let fridgeItemListCellFilledShoppingCartImage = UIImage(named: "shopping_fridgeItemListCell_filled")
    // Minus image on fridgeItemListCell
    static let fridgeItemListCellMinusButtonImage = UIImage(named: "minus_fridgeItemListCell")
    // Plus image on fridgeItemListCell
    static let fridgeItemListCellPlusButtonImage = UIImage(named: "plus_fridgeItemListCell")
    // Back button
    static let backButtonImage = UIImage(named: "back")
    // Circle close button
    static let circleCloseButton = UIImage(named: "close_circle")
    // Add button
    static let addButton = UIImage(named: "add")
    // Circled Add button
    static let circledAddButton = UIImage(named: "add_circle")
    // Scan button
    static let scanButton = UIImage(named: "scan")
    // Crown image
    static let crown = UIImage(named: "crown")
    // Category Images Name
    static let categoryImages = ["category_meat", "category_vegetable", "category_fruit", "category_snack", "category_banana", "category_beer", "category_can", "category_cherry", "category_coke", "category_iceCream", "category_pizza", "category_popcorn", "category_eggplant", "category_cake", "category_watermelon", "category_donut", "category_cookie", "category_milk", "category_carrot", "category_bread", "category_ham", "category_cheese", "category_sausage", "category_chips", "category_burger", "category_iceCreamBlue", "category_iceCreamPink", "category_jam", "category_egg", "category_chiliSauce", "category_candy", "category_coffee", "category_birthdayCake", "category_lobster", "category_banana", "category_orange", "category_fish", "category_mushroom", "category_seed", "category_salad", "category_cabage", "category_onion", "category_tomato", "category_chilli", "category_sweetPotato", "category_potato", "category_springOnion", "category_grape", "category_strawberry", "category_pineapple", "category_avocado", "category_water", "category_wine", "category_cleaning", "category_book", "category_pot", "category_pan", "category_iceDrink", "category_chocolateCake", "category_cookieDouble", "category_wineGlass", "category_seasoning", "category_seasoningDouble", "category_beer"]
    
    func resizeImage(to width: CGFloat) -> UIImage? {

        let ratio = width / self.size.width
        let height = self.size.height * ratio
        let dimension = min(width, height)
        let targetSize = CGSize(width: dimension, height: dimension)

        let rect = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height)

        UIGraphicsBeginImageContextWithOptions(targetSize, false, 0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
