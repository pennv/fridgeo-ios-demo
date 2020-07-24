//
//  Notification.swift
//
//
//  Created by Penn on 23/3/20.
//

import Foundation

extension Notification.Name {
    static let loginStatusChanged = Notification.Name("themeChanged")
    static let requestFridgeItemList = Notification.Name("requestFridgeItemList")
    static let receiveFridgeItemList = Notification.Name("receiveFridgeItemList")
    static let calendarCellClicked = Notification.Name("calendarCellClicked")
    static let dataUpdated = Notification.Name("dataUpdated")
    static let userUpdated = Notification.Name("userUpdated")
    static let failedToUpdateData = Notification.Name("failedToUpdateData")
    
    static let fridgeItemCellSelected = Notification.Name("fridgeItemCellSelected")
    static let shoppingItemCellSelected = Notification.Name("shoppingItemCellSelected")
    
    static let categoryUpdated = Notification.Name("categoryUpdated")
    static let categoryCellSelected = Notification.Name("categoryCellSelected")
}
