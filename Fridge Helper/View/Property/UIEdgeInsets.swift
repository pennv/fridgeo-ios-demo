//
//  UIEdgeInsets.swift
//  Fridge Helper
//
//  Created by Penn on 24/3/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

// Adjust size of images
extension UIEdgeInsets {
    
    static let PPTabBarImageInsets = UIEdgeInsets(top: 57, left: 6, bottom: 45, right: 6)
    
    static let PPLoginButtonImageInsets = UIEdgeInsets(top: CGFloat.PPLoginButtonHeight*0.323276, left: CGFloat.PPLoginButtonHeight*0.323276, bottom: CGFloat.PPLoginButtonHeight*0.323276, right: CGFloat.PPLoginButtonWidth - (CGFloat.PPLoginButtonHeight - CGFloat.PPLoginButtonHeight*0.323276))
    
    static let PPProfileViewGoProButtonImageInsets = UIEdgeInsets(top: CGFloat.PPProfileViewGoProButtonHeight*0.323276, left: CGFloat.PPProfileViewGoProButtonHeight*0.323276, bottom: CGFloat.PPProfileViewGoProButtonHeight*0.323276, right: CGFloat.PPProfileViewGoProButtonWidth - (CGFloat.PPProfileViewGoProButtonHeight - CGFloat.PPProfileViewGoProButtonHeight*0.323276))
    
    static let FridgeListInsects = UIEdgeInsets(top: CGFloat.PPFridgeItemListCollectionViewTopDistance, left: CGFloat.FridgeItemCellPositionX, bottom: CGFloat.PPFridgeItemListCollectionViewBottomDistance, right: 0)
}
