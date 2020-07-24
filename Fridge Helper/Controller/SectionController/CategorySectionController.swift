//
//  CategorySectionController.swift
//  Fridge Helper
//
//  Created by Penn on 16/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit
import IGListKit

class CategorySectionController: ListSectionController {
    
    private var category: NSDictionary?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
    
    // The object is from func object() of view controller
    override func didUpdate(to object: Any) {
        self.category = (object as? CategoryViewModel)?.category
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: CGFloat.PPCategoryCollectionViewCellHeight)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: CategoryCell = collectionContext?.dequeueReusableCell(of: CategoryCell.self, for: self, at: index) as? CategoryCell else {
            fatalError()
        }
        cell.renderCell(category: self.category)
        return cell
    }
    
    override func didSelectItem(at index: Int) {
        NotificationCenter.default.post(name: .categoryCellSelected, object: self, userInfo: ["selectedCategory" : self.category!] as [AnyHashable : Any])
    }
}
