//
//  FridgeListViewController.swift
//  Fridge Helper
//
//  Created by Penn on 22/3/20.
//  Copyright © 2020 Penn. All rights reserved.
//
/*
    Both of methods adapter.reloadData() and adapter.performUpdates()
    would result of objects being called so inside the objects we can
    modify the list elements based on searchText
*/

import UIKit
import IGListKit

class FridgeListViewController: PPViewController, ListAdapterDataSource, UISearchBarDelegate, ScannerDelegate {

    lazy var adapter: ListAdapter = { return ListAdapter(updater: ListAdapterUpdater(), viewController: self) }()
    var fridgeItemList = [FridgeItemList]()  // Container for IGListKit to render list data
    var fridgeItems: [NSDictionary] = []  // Entire actual list
    var filterFridgeItems: [NSDictionary] = []  // Filtered list based on selected category button
    var searchText: String = ""
    var isEditingSearchBar: Bool = false
    var selectedCategory: String?
    var previousCategoryButtonClicked: PPCategoryScrollerButton?
    // Fridge list view
    var scanner = ScannerViewController()
    let categoryScroller = PPCategoryScrollView()
    let collectionView = PPFridgeItemListCollectionView()
    let searchBar = PPSearchBar()
    let emptyBackground = PPFridgeListBackgroundImageView()
    var searchBarCancelButton: UIBarButtonItem?
    var rightBarButtons: [UIBarButtonItem]?
    
    
    
    // MARK: Logic
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Block operation for loading data
        self.displayLoadingIndicator(message: "Loading fridge...")
        // Configure navbar
        self.searchBar.delegate = self
        self.rightBarButtons = [UIBarButtonItem.addBarButton(self, action: #selector(onAddButtonClicked), imageName: "add_circle", heightAnchor: 26, widthAnchor: 33), UIBarButtonItem.addBarButton(self, action: #selector(onScannerButtonClicked), imageName: "scan", heightAnchor: 26, widthAnchor: 33)]
        self.searchBarCancelButton = UIBarButtonItem.addBarButton(self, action: #selector(onSearchBarCancelButtonClicked), imageName: "close_navBar", heightAnchor: 24, widthAnchor: 24)
        // Configure fridge list view
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.keyboardDismissMode = .onDrag
        self.adapter.collectionView = collectionView
        self.adapter.dataSource = self
        // Observer for data updated
        NotificationCenter.default.addObserver(self, selector: #selector(onDataUpdated(_:)), name: .dataUpdated, object: nil)
        // Observer for user profile updated
        NotificationCenter.default.addObserver(self, selector: #selector(onUserUpdated(_:)), name: .userUpdated, object: nil)
        // Observer for login status changed
        NotificationCenter.default.addObserver(self, selector: #selector(onLoginStatusChanged), name: .loginStatusChanged, object: nil)
        // Observer for cell selected
        NotificationCenter.default.addObserver(self, selector: #selector(onFridgeItemCellSelected(_:)), name: .fridgeItemCellSelected, object: nil)
        // Gesture recogniser for background image
        emptyBackground.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onAddButtonClicked)))
        // Load fridge item list view
        loadFridgeListView()
        // Load fridge item list and the result will be returned from onDataUpdated
        db.getAllFridgeItems()
    }
    
    
    @objc func onDataUpdated(_ notification: Notification) {
        // Update or recover fridge item list
        let fridgeItems = notification.userInfo!["fridgeItemList"]
        if fridgeItems != nil {
            // Filter and use new data to update list
            self.fridgeItems = fridgeItems as! [NSDictionary]
            if UserDefaults.standard.bool(forKey: "hideItemAddedToShoppingList") {
                for i in (0 ..< self.fridgeItems.count).reversed() {
                    if self.fridgeItems[i].object(forKey: "list") as! Int == 1 {
                        self.fridgeItems.remove(at: i)
                    }
                }
            }
            adapter.performUpdates(animated: true) { error in
                self.adapter.reloadData(completion: nil)
            }
            // Schedule notification for exipring items
            schaduleNotification()

        }
        // Resume operation
        self.dismiss(animated: true, completion: {
            // If list is recovered, display alert
            let error = notification.userInfo!["error_fridgeItemList"] as? String
            if error != nil {
                self.displayAlert(name: "Failed to Save", message: error! )
            }
        })
        
    }
    
    
    @objc func onUserUpdated (_ notification: Notification) {
        if let categoryList = notification.userInfo!["categoryList"] as? [NSDictionary] {
            let userProfile = UserDefaults.standard.dictionary(forKey: Key.userProfile)! as NSDictionary
            let mutableUserProfile = NSMutableDictionary.init(dictionary: userProfile)
            mutableUserProfile["category"] = categoryList
            UserDefaults.standard.set(NSDictionary.init(dictionary: mutableUserProfile), forKey: Key.userProfile)
            // Called from category popup window on successful update of cetegory
            addCategoryButton()
            // Dismiss loading indicator
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    @objc func onLoginStatusChanged() {
        // Load/reload data on user login/relogin
        let userProfile = UserDefaults.standard.dictionary(forKey: Key.userProfile) as NSDictionary?
        if userProfile != nil {
            db.getAllFridgeItems()
        }
    }
    
    
    @objc func onScannerButtonClicked() {
        // Present scanner view
        scanner.delegate = self
        scanner.modalPresentationStyle = .fullScreen
        scanner.fridgeItemList = fridgeItems
        present(scanner, animated: true, completion: nil)
    }
    
    
    func barcode(_ item: NSDictionary) {
        if let error = item["error"] as? String {
            scanner.dismiss(animated: true, completion: {
                self.displayAlert(name: "Opoos!!!", message: error)
            })
            // Reload scanner
            scanner = ScannerViewController()
            return
        }
        scanner.dismiss(animated: true, completion: nil)
        let fridgeItemPopupWindow = PPFridgeItemPopupWindowView(selectedFridgeItem: item)
        let popupView = PPPopupView(popupWindowView: fridgeItemPopupWindow)
        UIApplication.shared.windows.first!.addSubview(popupView)
    }
    
    
    @objc func onAddButtonClicked() {
        // If user has not added the item with such a name
        let userProfile = UserDefaults.standard.dictionary(forKey: Key.userProfile)! as NSDictionary
        guard let purchaseQuantity = userProfile.object(forKey: "purchase") as? Int else {
            displayAlert(name: "Sorry", message: "There is an error with the purchase number")
            return
        }
        // If user attemps to add more item more than it purchased,
        // display purchase view
        if db.fridgeItemList!.count >= purchaseQuantity {
            // Display purchase view
            present(PurchaseViewController(), animated: true, completion: nil)
            return
        }
        // If user purchase validate, display adding popup
        let fridgeItemPopupWindow = PPFridgeItemPopupWindowView()
        let popupView = PPPopupView(popupWindowView: fridgeItemPopupWindow)
        tabBarController?.view.addSubview(popupView)
        //UIApplication.shared.windows.first!.addSubview(popupView)  // To cover entire screen including navbar and tabbar
    }
    
    
    func getDays(_ rawDate: String?) -> Int? {
        if rawDate == nil || rawDate == "" { return nil }
        // Number of days from tody to expired date
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
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
        let day = local[8 ..< 10]
        let month = local[5 ..< 7]
        let year = local[0 ..< 4]
        let ExpiredDateString = year + "-" + month + "-" + day
        formatter.dateFormat = "yyyy-MM-dd"
        let expiredDate = formatter.date(from: ExpiredDateString)
        let days = Calendar.current.dateComponents([.day], from: Date(), to: expiredDate!).day
        return days!
    }
    
    
    @objc func onFridgeItemCellSelected(_ notification: Notification) {
        // Notification from fridge item list section controller
        if let index = notification.userInfo!["indexOfSelectedFridgeItem"] as? Int {
            let selectedFridgeItem = filterFridgeItems[index]
            let fridgeItemPopupWindow = PPFridgeItemPopupWindowView(selectedFridgeItem: selectedFridgeItem)
            let popupView = PPPopupView(popupWindowView: fridgeItemPopupWindow)
            tabBarController?.view.addSubview(popupView)
            //UIApplication.shared.windows.first!.addSubview(popupView)  // To cover entire screen including navbar and tabbar
        }
    }
    
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        // Change background of fridge list
        if fridgeItems.count < 1 && !isEditingSearchBar {
            view.addSubview(emptyBackground)
            view.bringSubviewToFront(emptyBackground)
        } else {
            emptyBackground.removeFromSuperview()
        }
        filterFridgeItems = []
        self.collectionView.keyboardDismissMode = .onDrag
        // Sort list alphabetlly
        fridgeItems = fridgeItems.sorted { item1, item2 in
            return (item2["name"] as! String).lowercased() > (item1["name"] as! String).lowercased()
        }
        // When user start searching (search bar has content)
        if self.searchText != "" {
            for item in self.fridgeItems {
                let name = item.object(forKey: "name") as! String
                if name.lowercased().contains(self.searchText.lowercased()) {
                    filterFridgeItems.append(item)
                }
            }
            if filterFridgeItems.count == 0 { self.collectionView.keyboardDismissMode = .none }
        // When user start searching (search bar has no content) show empty screen
        } else if isEditingSearchBar {
            filterFridgeItems = []
            self.collectionView.keyboardDismissMode = .none
        // When user is not searching
        } else {
            if self.selectedCategory != nil && self.selectedCategory != "All" && self.selectedCategory != "＋" {
                for item in self.fridgeItems {
                    if let category = item.object(forKey: "category") as? String {
                        if category.lowercased().contains(self.selectedCategory!.lowercased()) {
                            filterFridgeItems.append(item)
                        }
                    }
                }
            } else {
                filterFridgeItems = self.fridgeItems
            }
        }
        // Seal and send list
        if self.fridgeItemList.count > 0 {
            // Each element in [ListDiffable] will be rederned to a list
            self.fridgeItemList[0] = FridgeItemList(list: filterFridgeItems)
        } else {
            self.fridgeItemList.append(FridgeItemList(
                list: filterFridgeItems))
        }
        return self.fridgeItemList
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // If search bar is re-focused during the search (search bar
        // already contained text) then do not perform animation
        if searchBar.text!.count > 0 { return }
        navigationItem.rightBarButtonItems = nil
        navigationItem.rightBarButtonItem = self.searchBarCancelButton
        self.isEditingSearchBar = true
        self.tabBarController?.tabBar.isHidden = true
        // Ease out category scroller and move the collection view up
        UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {
            self.categoryScroller.alpha = 0
            self.collectionView.alpha = 0
            self.categoryScroller.frame.origin.x = -CGFloat.width
            self.collectionView.frame.origin.x = CGFloat.width
        }, completion: { _ in
            self.categoryScroller.isHidden = true
            self.collectionView.alpha = 1
            self.collectionView.frame.origin.y = CGFloat.PPFridgeItemListCollectionViewSearchResultPositionY
            self.collectionView.frame.origin.x = CGFloat.PPFridgeItemListCollectionViewPositionX
        })
        // Udpate data
        self.adapter.performUpdates(animated: true, completion: nil)
    }
    
    
    @objc func onSearchBarCancelButtonClicked() {
        self.searchText = ""
        self.isEditingSearchBar = false
        self.tabBarController?.tabBar.isHidden = false
        self.collectionView.keyboardDismissMode = .onDrag
        searchBar.text = nil
        searchBar.showsCancelButton = false
        navigationItem.rightBarButtonItems = self.rightBarButtons
        // Remove focus from the search bar.
        searchBar.endEditing(true)
        // Ease in category scroller and move the collection view up
        self.categoryScroller.isHidden = false
        self.collectionView.alpha = 0
        self.collectionView.frame.origin.y = CGFloat.PPFridgeItemListCollectionViewPositionY
        self.collectionView.frame.origin.x = CGFloat.width
        UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {
            self.categoryScroller.alpha = 1
            self.collectionView.alpha = 1
            self.categoryScroller.frame.origin.x = CGFloat.PPCategoryScrollViewPositionX
            self.collectionView.frame.origin.x = CGFloat.PPFridgeItemListCollectionViewPositionX
        })
        // Udpate data
        adapter.performUpdates(animated: false, completion: nil)
    }
    
    
    @objc func onCategoryButtonClicked(_ categoryButton: PPCategoryScrollerButton) {
        if categoryButton.getCategoryName() != "＋" {
            // Change status of clicked button and previous clicked button
            if self.previousCategoryButtonClicked != nil { self.previousCategoryButtonClicked!.setClickStatus(false) }
            categoryButton.setClickStatus(true)
            self.previousCategoryButtonClicked = categoryButton
            // Move clicked button to the middle
            let buttonPosition = categoryButton.frame.origin.x + categoryButton.frame.width/2 - self.categoryScroller.center.x
            var contentOffsetPositionX: CGFloat = 0
            if buttonPosition < 0
            || self.categoryScroller.contentSize.width < self.categoryScroller.frame.size.width { // When the clicked button on the left hand side of screen centre
                contentOffsetPositionX = 0
            } else if self.categoryScroller.contentSize.width - buttonPosition < self.categoryScroller.frame.size.width
            && self.categoryScroller.contentSize.width > self.categoryScroller.frame.size.width { // When the clicked button on the right hand side of screen centre
                contentOffsetPositionX = self.categoryScroller.contentSize.width - self.categoryScroller.frame.size.width
            } else { // When the clicked button on the middle
                contentOffsetPositionX = buttonPosition
            }
            let contentOffset = CGPoint(x: contentOffsetPositionX, y: categoryButton.frame.origin.y)
            self.categoryScroller.setContentOffset(contentOffset, animated: true)
            // Filter data
            selectedCategory = categoryButton.getCategoryName()
            self.adapter.performUpdates(animated: true, completion: nil)
        // User clicks category editing button and open up category editing popup window
        } else {
            let categoryPopupWindow = PPCategoryPopupWindowView()
            let popupView = PPPopupView(popupWindowView: categoryPopupWindow)
            UIApplication.shared.windows.first!.addSubview(popupView)  // To cover entire screen including navbar and tabbar
        }
    }
    
    
    func schaduleNotification() {
        // Ask for notification permission
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                center.removeAllPendingNotificationRequests()
                // Get current date info
                let currentCanlendar = Calendar(identifier: .gregorian)
                let days = currentCanlendar.range(of: .day, in: .month, for: Date())!.count
                let formatter = DateFormatter()
                // Initialise based on numbe of days of current month
                var expiringFridgeItems: [Int : Int] = [:]
                for day in 1...days {
                    expiringFridgeItems[day] = 0
                }
                // Bind date and number to expiringFridgeItems
                for item in self.fridgeItems {
                    formatter.timeZone = TimeZone(abbreviation: "UTC")
                    let rawDate = item.object(forKey: "date") as? String
                    if rawDate == nil || rawDate == "" { continue }  // Some items may not have date
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    var utc = formatter.date(from: rawDate!)
                    // utc might have been formatted date
                    if utc == nil {
                        formatter.dateFormat = "yyyy/MM/dd"
                        utc = formatter.date(from: rawDate!)
                    }
                    formatter.timeZone = .current
                    let StringLocalTime = formatter.string(from: utc!)
                    let formattedStringLocalTime = StringLocalTime[0 ..< 4] + "-" + StringLocalTime[5 ..< 7] + "-" + StringLocalTime[8 ..< 10]
                    formatter.dateFormat = "yyyy-MM-dd"
                    let localTime = formatter.date(from: formattedStringLocalTime)
                    // ID is combination of year, month and day
                    let notificationId = formattedStringLocalTime
                    let notificationContent = UNMutableNotificationContent()
                    notificationContent.title = "You have item(s) expire today"
                    notificationContent.subtitle = "Tap to see details"
                    let timeInterval = localTime?.timeIntervalSinceNow
                    if timeInterval! < 0 { continue } // Ignore the items expired
                    let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval!, repeats: false)
                    let notificationRequest = UNNotificationRequest(identifier: notificationId, content: notificationContent, trigger: notificationTrigger)
                    UNUserNotificationCenter.current().add(notificationRequest)
                }
            } else {
                print("FH: notification permission not granted")
            }
        }
    }
    
    
    
    // MARK: View
    
    
    
    func loadFridgeListView() {
        // Add search bar
        navigationItem.titleView = searchBar
        // Add bar button
        navigationItem.rightBarButtonItems = self.rightBarButtons
        // Add categpry scroller
        view.addSubview(categoryScroller)
        // Add category buttons on scroller
        self.addCategoryButton()
        // Load fridge list
        view.addSubview(collectionView)
    }
    
    
    func addCategoryButton() {
        for oldCategoryButton in self.categoryScroller.subviews {
           oldCategoryButton.removeFromSuperview()
        } // Remove all old buttons on scroller
        var contentWidth = CGFloat.PPCategoryScrollViewContentWidth // Blank on the left side of "All" button
        var categoryButton = UIButton()
        let userProfile = UserDefaults.standard.dictionary(forKey: Key.userProfile) as NSDictionary?
        guard userProfile != nil else {
            return
        }
        let category = NSMutableArray.init(array: (userProfile!.object(forKey: "category") as? NSArray)!)
        // Add "All" button on the first
        category.insert(NSDictionary.init(object: "All", forKey: "name" as NSCopying), at: 0)
        // Add "+" button on the last
        category.add(NSDictionary.init(object: "＋", forKey: "name" as NSCopying))
        // Add category buttons
        for i in 0 ..< category.count {
            let categoryName = ((category[i] as! NSDictionary).object(forKey: "name") as? String)!.capitalizingFirstLetter()
            categoryButton = PPCategoryScrollerButton(categoryName)
            categoryButton.frame.origin.x = contentWidth // Each button has different x on the scroll view
            contentWidth = categoryButton.frame.origin.x + categoryButton.frame.size.width // Update x for next button
            categoryButton.addTarget(self, action: #selector(onCategoryButtonClicked(_ :)), for: .touchUpInside)
            self.categoryScroller.addSubview(categoryButton)
            if i == 0 { categoryButton.sendActions(for: .touchUpInside) } // "All" will be selected by default
        }
        // Adjust content width of scroller
        contentWidth += CGFloat.FridgeItemCellPositionX // Blank on the right side of "+" button
        self.categoryScroller.contentSize.width = contentWidth
    }
    
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return FridgeListSectionController()
    }
    
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {return nil}
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        adapter.performUpdates(animated: true, completion: nil)
    }
}
