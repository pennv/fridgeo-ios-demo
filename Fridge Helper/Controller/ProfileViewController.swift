//
//  ProfileViewController.swift
//  Fridge Helper
//
//  Created by Penn on 22/3/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit
import IGListKit

class ProfileViewController: PPViewController, ListAdapterDataSource {
    
    let settingBarButton = PPProfileSettingBarButton()
    let userProfileImageView = PPUserProfileImageView()
    let usernameLabel = PPUsernameLabel()
    let goProButton = PPProfileViewGoProButton()
    let fridgeItemCountLabel = PPFridgeItemCountLabel()
    let shoppingListCountLabel = PPShoppingListCountLabel()
    let recipeCountLabel = PPRecipeCountLabel()
    
    // Canlendar view
    lazy var adapter: ListAdapter = {return ListAdapter(updater: ListAdapterUpdater(), viewController: self)}()
    let collectionView = PPCalendarCollectionView()
    var months = [Month]()
    
    // As the format of expiringFridgeItems is not suitable for
    // storing objects for displaying details
    var fridgeItemsToDisplay = [[NSDictionary]]()
    
    
    
    // MARK: Logic
    
    
    
    // Load/reload calendar view only when fridge item list received
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure canlendar view
        self.adapter.collectionView = collectionView
        self.adapter.dataSource = self
        // Observer for data updated
        NotificationCenter.default.addObserver(self, selector: #selector(onDataUpdated(_:)), name: .dataUpdated, object: nil)
        // Observer to get which cell in the calendar is clicked
        NotificationCenter.default.addObserver(self, selector: #selector(onCalendarCellClicked(_:)), name: .calendarCellClicked, object: nil)
        // Load profile view
        self.loadProfileView()
        // Load fridge item list and result will be returned from onDataUpdated
        db.getAllFridgeItems()
    }
    
    @objc func onDataUpdated(_ notification: Notification) {
        // Update or recover fridge item list
        let fridgeItemList = notification.userInfo!["fridgeItemList"]
        if fridgeItemList != nil {
            self.bindDataToCalendar(fridgeItemList as! [NSDictionary])
        }
        // If list is recovered, display alert
        let error = notification.userInfo!["error_fridgeItemList"] as? String
        if error != nil {
            self.displayAlert(name: "Failed to update fridge", message: error!)
        }
    }
    
    @objc func onCalendarCellClicked(_ notification: Notification) {
        let selectedDay = (notification.userInfo!["index"] as? Int)!
        // Only show details of fridge items that are expiring in
        // selected day
        if self.fridgeItemsToDisplay.count < 1 {return}  // Empty fridge item list would cause crash
        if self.fridgeItemsToDisplay[selectedDay - 1].count < 1 {return}
        let popupWindow = PPProfilePopupWindowView(selectedDay: selectedDay, fridgeItemsToDisplay: self.fridgeItemsToDisplay)
        let popupView = PPPopupView(popupWindowView: popupWindow)
        UIApplication.shared.windows.first!.addSubview(popupView)  // To entir screen including navbar and tabbar
    }
    
    // Setting button onClicked action
    @objc func onSettingButtonClicked() {
        let settingViewController = SettingViewController()
        settingViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(settingViewController, animated: true)
    }
    
    func bindDataToCalendar(_ fridgeItemList: [NSDictionary]) {
        // Get current date info
        let currentCanlendar = Calendar(identifier: .gregorian)
        let currentMonth = currentCanlendar.component(.month, from: Date())
        let days = currentCanlendar.range(of: .day, in: .month, for: Date())!.count
        let formatter = DateFormatter()
        // Initialise based on numbe of days of current month
        var expiringFridgeItems: [Int : Int] = [:]
        var fridgeItemsToDisplay = [[NSDictionary]](repeating: [], count: days)
        for day in 1...days {
            expiringFridgeItems[day] = 0
        }
        // Bind date and number to expiringFridgeItems
        for item in fridgeItemList {
            formatter.timeZone = TimeZone(abbreviation: "UTC")
            let rawDate = item.object(forKey: "date") as? String
            if rawDate == nil || rawDate == "" { continue }  // Some items may not have date
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            var utc = formatter.date(from: rawDate!)
            // First formatter is for date from server,
            // second formatter is for date from local
            // popup window update (through dataUpdated
            // observer) as successful updated item will
            // not be the same format as the one from server
            if utc == nil {
                formatter.dateFormat = "yyyy/MM/dd"
                utc = formatter.date(from: rawDate!)
            }
            formatter.timeZone = .current
            let local = formatter.string(from: utc!)
            let day = Int(local[8 ..< 10])
            let month = Int(local[5 ..< 7])
            if month == currentMonth {
                expiringFridgeItems[day!]! += 1
                fridgeItemsToDisplay[day!-1].append(item)
            }
            // Display the data when cell is clicked
            self.fridgeItemsToDisplay = fridgeItemsToDisplay
        }
        // Bind data to calendar
        let month = Month(
            name: DateFormatter().monthSymbols[currentCanlendar.component(.month, from: Date()) - 1],
            days: days,
            expiringFridgeItems: expiringFridgeItems
        )
        if months.count > 0 {months[0] = month} else {months.append(month)}
        adapter.performUpdates(animated: true, completion: nil)
    }
    
    @objc func onGoProButtonTapped() {
        present(PurchaseViewController(), animated: true, completion: nil)
    }
    
    
    
    // MARK: View
    

    
    func loadProfileView() {
        // Setup nav bar button
        settingBarButton.addTarget(self, action: #selector(onSettingButtonClicked), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: settingBarButton)
        // Setup user profile image
        view.addSubview(userProfileImageView)
        // Setup username label
        view.addSubview(usernameLabel)
        // Go Pro button
        goProButton.addTarget(self, action: #selector(onGoProButtonTapped), for: .touchUpInside)
        view.addSubview(goProButton)
        // Load calendar
        view.addSubview(collectionView)
        // Load summary label
        view.addSubview(fridgeItemCountLabel)
        view.addSubview(shoppingListCountLabel)
        view.addSubview(recipeCountLabel)
    }
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return months
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return CalendarSectionController()
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}
