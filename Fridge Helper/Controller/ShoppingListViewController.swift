//
//  ShoppingListViewController.swift
//  Fridge Helper
//
//  Created by Penn on 22/3/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit
import IGListKit

class ShoppingListViewController: PPViewController, ListAdapterDataSource, UISearchBarDelegate {
    
    lazy var adapter: ListAdapter = { return ListAdapter(updater: ListAdapterUpdater(), viewController: self) }()
    var shoppingItemList = [FridgeItemList]()
    var shoppingItems: [NSDictionary] = []
    var filterShoppingItems: [NSDictionary] = []
    var searchText: String = ""
    var isEditingSearchBar: Bool = false
    var selectedCategory: String?
    var previousCategoryButtonClicked: PPCategoryScrollerButton?

    let emptyBackground = PPShoppingListBackgroundImageView()
    let categoryScroller = PPCategoryScrollView()
    let collectionView = PPFridgeItemListCollectionView()
    let searchBar = PPSearchBar()
    lazy fileprivate var rightBarButton = UIBarButtonItem.addBarButton(self, action: #selector(onSearchBarAddButtonClicked), imageName: "add_circle", heightAnchor: 26, widthAnchor: 33)
    lazy fileprivate var searchBarCancelButton = UIBarButtonItem.addBarButton(self, action: #selector(onSearchBarCancelButtonClicked), imageName: "close_navBar", heightAnchor: 24, widthAnchor: 24)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        // Observer for data updated
        NotificationCenter.default.addObserver(self, selector: #selector(onDataUpdated(_:)), name: .dataUpdated, object: nil)
        // Observer for cell selected
        NotificationCenter.default.addObserver(self, selector: #selector(onShoppingItemCellSelected(_:)), name: .shoppingItemCellSelected, object: nil)
        emptyBackground.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onSearchBarAddButtonClicked)))
        // Configure fridge list view
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .onDrag
        adapter.collectionView = collectionView
        adapter.dataSource = self
        // Load views
        loadShoppingListView()
        // Load shopping list and the result will be returned from onDataUpdated
        db.getAllFridgeItems()
    }
    
    
    @objc func onDataUpdated(_ notification: Notification) {
        // Update or recover fridge item list
        let shoppingItems = notification.userInfo!["fridgeItemList"]
        if shoppingItems != nil {
            // Keep items with property list is "1"
            self.shoppingItems = shoppingItems as! [NSDictionary]
            for i in (0 ..< self.shoppingItems.count).reversed() {
                if self.shoppingItems[i].object(forKey: "list") as? Double != 1 {
                    self.shoppingItems.remove(at: i)
                }
            }
            // Use new data to update list
            adapter.performUpdates(animated: true) { error in
                self.adapter.reloadData(completion: nil)
            }
            // Update category scroller
            addCategoryButton()
        }
        // Resume operation
        self.dismiss(animated: true, completion: nil)
        // If list is recovered, display alert
        let error = notification.userInfo!["error_shoppingList"] as? String
        if error != nil {
            self.displayAlert(name: "Failed to Save", message: error! )
        }
    }
    
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        // Change background of fridge list
        if shoppingItems.count < 1 && !isEditingSearchBar {
            view.addSubview(emptyBackground)
            view.bringSubviewToFront(emptyBackground)
        } else {
            emptyBackground.removeFromSuperview()
        }
        filterShoppingItems = []
        collectionView.keyboardDismissMode = .onDrag
        // Sort list alphabetlly
        shoppingItems = shoppingItems.sorted { item1, item2 in
            return (item2["name"] as! String).lowercased() > (item1["name"] as! String).lowercased()
        }
        // When user start searching (search bar has content)
        if searchText != "" {
            for item in shoppingItems {
                let name = item.object(forKey: "name") as! String
                if name.lowercased().contains(self.searchText.lowercased()) {
                    filterShoppingItems.append(item)
                }
            }
            if filterShoppingItems.count == 0 { collectionView.keyboardDismissMode = .none }
        // When user start searching (search bar has no content) show empty screen
        } else if isEditingSearchBar {
            filterShoppingItems = []
            self.collectionView.keyboardDismissMode = .none
        // When user is not searching
        } else {
            if selectedCategory != nil && selectedCategory != "All" {
                for item in shoppingItems {
                    if let category = item.object(forKey: "category") as? String {
                        if category.lowercased().contains(self.selectedCategory!.lowercased()) {
                            filterShoppingItems.append(item)
                        }
                    }
                }
            } else {
                filterShoppingItems = shoppingItems
            }
        }
        // Seal and send list
        if shoppingItemList.count > 0 {
            // Each element in [ListDiffable] will be rederned to a list
            shoppingItemList[0] = FridgeItemList(list: filterShoppingItems)
        } else {
            shoppingItemList.append(FridgeItemList(
                list: filterShoppingItems))
        }
        return shoppingItemList
    }
    
    
    @objc func onShoppingItemCellSelected(_ notification: Notification) {
        if let index = notification.userInfo!["indexOfSelectedShoppingItem"] as? Int {
            let selectedShoppingItem = filterShoppingItems[index]
            let shoppingItemPopupWindow = PPShppingListPopupWindowView(selectedShoppingItem: selectedShoppingItem)
            let popupView = PPPopupView(popupWindowView: shoppingItemPopupWindow)
            tabBarController?.view.addSubview(popupView)
        }
    }
    
    
    @objc func onSearchBarAddButtonClicked() {
        let shoppingItemPopupWindow = PPShppingListPopupWindowView()
        let popupView = PPPopupView(popupWindowView: shoppingItemPopupWindow)
        tabBarController?.view.addSubview(popupView)
    }
    
    
    @objc func onSearchBarCancelButtonClicked() {
        // Switch to add button
        searchText = ""
        isEditingSearchBar = false
        tabBarController?.tabBar.isHidden = false
        collectionView.keyboardDismissMode = .onDrag
        searchBar.text = nil
        searchBar.showsCancelButton = false
        navigationItem.rightBarButtonItem = rightBarButton
        // Remove focus from the search bar.
        searchBar.endEditing(true)
        // Ease in category scroller and move the collection view up
        categoryScroller.isHidden = false
        collectionView.alpha = 0
        collectionView.frame.origin.y = CGFloat.PPFridgeItemListCollectionViewPositionY
        collectionView.frame.origin.x = CGFloat.width
        UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {
            self.categoryScroller.alpha = 1
            self.collectionView.alpha = 1
            self.categoryScroller.frame.origin.x = CGFloat.PPCategoryScrollViewPositionX
            self.collectionView.frame.origin.x = CGFloat.PPFridgeItemListCollectionViewPositionX
        })
        // Udpate data
        adapter.performUpdates(animated: false, completion: nil)
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // Switch to self-defined cancel button
        navigationItem.rightBarButtonItem = searchBarCancelButton
        isEditingSearchBar = true
        tabBarController?.tabBar.isHidden = true
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
        adapter.performUpdates(animated: true, completion: nil)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        adapter.performUpdates(animated: true, completion: nil)
    }
    
    
    func loadShoppingListView() {
        // Add search bar
        navigationItem.titleView = searchBar
        // Add bar button
        navigationItem.rightBarButtonItem = rightBarButton
        // Load shopping list
        view.addSubview(collectionView)
        // Add categpry scroller
        view.addSubview(categoryScroller)
        // Add category buttons on scroller
        addCategoryButton()
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
        let list = NSMutableArray.init(array: (userProfile!.object(forKey: "category") as? NSArray)!)
        var categoryList: [String] = []
        // Filter category
        for category in list {
            let categoryName = (category as! NSDictionary).object(forKey: "name") as! String
            for item in shoppingItems {
                if categoryName == item.object(forKey: "category") as? String {
                    categoryList.append(categoryName)
                    break
                }
            }
        }
        // Add "All" button on the first
        if shoppingItems.count > 0 { categoryList.insert("All", at: 0) }
        // Add category buttons
        for categoryName in categoryList {
            categoryButton = PPCategoryScrollerButton(categoryName.capitalizingFirstLetter())
            categoryButton.frame.origin.x = contentWidth // Each button has different x on the scroll view
            contentWidth = categoryButton.frame.origin.x + categoryButton.frame.size.width // Update x for next button
            categoryButton.addTarget(self, action: #selector(onCategoryButtonClicked(_ :)), for: .touchUpInside)
            self.categoryScroller.addSubview(categoryButton)
            if categoryName == "All" { categoryButton.sendActions(for: .touchUpInside) }
        }
        // Adjust content width of scroller
        contentWidth += CGFloat.FridgeItemCellPositionX // Blank on the right side of "+" button
        categoryScroller.contentSize.width = contentWidth
    }
    
    
    @objc func onCategoryButtonClicked(_ categoryButton: PPCategoryScrollerButton) {
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
    }
    
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController { return ShoppingListSectionController() }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}
