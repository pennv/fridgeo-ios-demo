//
//  UIBarButtonItem.swift
//  Fridge Helper
//
//  Created by Penn on 27/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

extension UIBarButtonItem {

    static func addBarButton(_ target: Any?, action: Selector, imageName: String, heightAnchor: Int, widthAnchor: Int) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        let deviceName = UIDevice.modelName
        if deviceName == "iPhone 6" || deviceName == "iPhone 6s" || deviceName == "iPhone SE" || deviceName == "iPhone 7" || deviceName == "iPhone 8" || deviceName == "iPhone 11" ||  deviceName == "iPhone SE (2nd generation)" {
            button.setImage(UIImage(named: imageName + "_small")!.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            button.setImage(UIImage(named: imageName)!.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        button.addTarget(target, action: action, for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: button)
        barButtonItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        barButtonItem.customView?.heightAnchor.constraint(equalToConstant: CGFloat(heightAnchor)).isActive = true
        barButtonItem.customView?.widthAnchor.constraint(equalToConstant: CGFloat(widthAnchor)).isActive = true

        return barButtonItem
    }
}
