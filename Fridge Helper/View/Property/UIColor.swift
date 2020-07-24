//
//  UIColor.swift
//  Fridge Helper
//
//  Created by Penn on 24/3/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

extension UIColor {
    
    struct Background {
        static let light = UIColor.white.darker(by: 3)
        static let dark = UIColor(red:0.07, green:0.07, blue:0.07, alpha:1.00)
    }
    
    struct PPTabBar {
        struct tintColor {
            static let light = UIColor.Background.light
            static let dark = UIColor.black.lighter(by: 10)
        }
        struct selectedImageTintColor {
            static let light = UIColor.black.lighter(by: 10)
            static let dark = UIColor.white
        }
        struct unselectedItemTintColor {
            static let light = UIColor.black.lighter(by: 60)
            static let dark = UIColor.white.darker(by: 50)
        }
    }
    
    struct PPButton {
        struct backgroundColor {
            static let light = UIColor.Background.light
            static let dark = UIColor.Background.dark
        }
        static let borderColor = UIColor.gray.cgColor
        struct fontColor {
            static let light = UIColor.black
            static let dark = UIColor.white
        }
        static let PPCategoryButtonFontColor = UIColor.gray
        static let PPScannerButtonBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
    
    struct PPCell {
        struct CalendarDayCellBackgroundColor {
            static let light = UIColor.Background.light?.darker(by: 2.5)
            static let dark = UIColor.PPTabBar.tintColor.dark?.lighter(by: 5)
        }
        struct FridgeItemCellBackgroundColor {
            static let light = UIColor.Background.light?.darker(by: 2.5)
            static let dark = UIColor.PPTabBar.tintColor.dark?.lighter(by: 5)
        }
        struct FridgeItemCellBorderColor {
            static let red = UIColor(red: 0.9059, green: 0.298, blue: 0.2353, alpha: 1.0) /* #e74c3c */
            static let yellow = UIColor(red: 0.9451, green: 0.7686, blue: 0.0588, alpha: 1.0) /* #f1c40f */
            static let green = UIColor(red: 0.451, green: 0.8235, blue: 0.0863, alpha: 1.0) /* #73d216 */
            static let gray = UIColor(red: 0.498, green: 0.549, blue: 0.5529, alpha: 1.0) /* #7f8c8d */
        }
    }
    
    
    struct PPLabel {
        struct PPCountLabel {
            struct border {
                static let light = UIColor.gray.lighter(by: 35)
                static let dark = UIColor.gray.darker(by: 25)
            }
            static let title = UIColor.gray.lighter(by: 15)
        }
        struct PPFridgeItemListCellLabel {
            struct border {
                static let light = UIColor.gray.lighter(by: 35)
                static let dark = UIColor.gray.darker(by: 25)
            }
        }
    }
    
    
    struct PPView {
        struct PPPopupViewBackgroundColor {
            static let light = UIColor(white: 1, alpha: 0.9).darker(by: 3)
            static let dark = UIColor(red:0.07, green:0.07, blue:0.07, alpha:0.9)
        }
        struct PPPopupWindowBackgroundColor {
            static let light = Background.light
            static let dark = Background.dark
        }
    }
    
    
    struct PPTextView {
        struct PPProfilePopupWindowContenTextViewBackgroundColor {
            static let light = PPView.PPPopupWindowBackgroundColor.light
            static let dark = PPView.PPPopupWindowBackgroundColor.dark
        }
    }
    
    
    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }

    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }

    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }

}
