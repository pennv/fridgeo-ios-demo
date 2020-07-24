//
//  FridgeListSectionController.swift
//  Fridge Helper
//
//  Created by Penn on 26/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit
import IGListKit
import SwipeCellKit

class FridgeListSectionController: ListBindingSectionController<ListDiffable>, ListBindingSectionControllerDataSource, ListBindingSectionControllerSelectionDelegate, SwipeCollectionViewCellDelegate {
    
    var fridgeItemList: [NSDictionary]? // For swipe action to find item id and delete
    
    override init() {
        super.init()
        dataSource = self
        selectionDelegate = self
        // Position of cell
        self.inset = UIEdgeInsets.FridgeListInsects
        // Vertical space
        self.minimumLineSpacing = CGFloat.PPFridgeItemListCollectionViewLineSpacing
        // Horizental space
        // self.minimumInteritemSpacing = 100
    }
    
    // Build data structure (based on model) cell by cell
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, viewModelsFor object: Any) -> [ListDiffable] {
        // This param "object" is the data passed from view controller
        guard let fridgeList = object as? FridgeItemList else {return []}
        fridgeItemList = fridgeList.list
        var viewModels = [ListDiffable]()
        for item in fridgeList.list {
            let viewModel = (FridgeItemViewModel(
                _id: item.object(forKey: "_id") as! String,
                name: item.object(forKey: "name") as! String,
                quantity: item.object(forKey: "quantity") as! Double,
                list: item.object(forKey: "list") as! Int,
                need: item.object(forKey: "need") as? Double ?? nil,
                category: item.object(forKey: "category") as? String ?? nil,
                date: item.object(forKey: "date") as? String ?? nil,
                barcode: item.object(forKey: "barcode") as? String ?? nil,
                note: item.object(forKey: "note") as? String ?? nil
            ))
            viewModels.append(viewModel)
        }
        return viewModels
    }
    
    // Render view for each cell
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>,
                           cellForViewModel viewModel: Any,
                           at index: Int) -> UICollectionViewCell & ListBindable {
        let cellClass: SwipeCollectionViewCell.Type
        cellClass = FridgeItemCell.self
        guard let cell = collectionContext?.dequeueReusableCell(of: cellClass, for: self, at: index) as? SwipeCollectionViewCell & ListBindable else {
            fatalError()
        }
        cell.delegate = self
        return cell
    }
    
    // Render view for each cell (size of cell)
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>,
                           sizeForViewModel viewModel: Any,
                           at index: Int) -> CGSize {
        return CGSize(width: CGFloat.FridgeItemCellWidth, height: CGFloat.FridgeItemCellHeight)
    }
    
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didSelectItemAt index: Int, viewModel: Any) {
        NotificationCenter.default.post(name: .fridgeItemCellSelected, object: self, userInfo: ["indexOfSelectedFridgeItem" : index] as [AnyHashable : Any])
    }
    
    // For cell swipe actions
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .left else { return nil }
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            guard self.fridgeItemList != nil else {
                return
            }
            let fridgeItemId = self.fridgeItemList![indexPath[1]].object(forKey: "_id") as! String
            db.deleteFridgeItem(fridgeItemId: fridgeItemId)
        }
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")
        return [deleteAction]
    }
    
    // For swipe action options
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructiveAfterFill
        options.transitionStyle = .border
        return options
    }
    
    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didDeselectItemAt index: Int, viewModel: Any) {}

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didHighlightItemAt index: Int, viewModel: Any) {}

    func sectionController(_ sectionController: ListBindingSectionController<ListDiffable>, didUnhighlightItemAt index: Int, viewModel: Any) {}
}
