//
//  EditingCategorySectionController.swift
//  Fridge Helper
//
//  Created by Penn on 19/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit
import IGListKit

class EditingCategorySectionController: ListSectionController {
    
    private var imageName: String?
    var cell: CategoryImageCell?
        
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 3, left: 28, bottom: 10, right: 10)
    }
    
    // The object is from func object() of view controller
    override func didUpdate(to object: Any) {
        self.imageName = object as? String
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: CGFloat.PPCategoryimageCollectionViewCellWidth, height: CGFloat.PPCategoryimageCollectionViewCellHeight)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: CategoryImageCell = collectionContext?.dequeueReusableCell(of: CategoryImageCell.self, for: self, at: index) as? CategoryImageCell else {
            fatalError()
        }
        cell.renderCell(categoryImageName: self.imageName)
        self.cell = cell
        return cell
    }
    
    override func didSelectItem(at index: Int) {
        NotificationCenter.default.post(name: .categoryCellSelected, object: self, userInfo: ["imageName" : self.imageName!] as [AnyHashable : Any])
    }
}
