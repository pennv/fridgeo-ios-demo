//
//  CategoryViewModel.swift
//  Fridge Helper
//
//  Created by Penn on 17/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import Foundation
import IGListKit

final class CategoryViewModel {

    let category: NSDictionary
    
    init(category: NSDictionary) {
        self.category = category
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryViewModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        let categoryName = self.category.object(forKey: "name") as! NSObjectProtocol
        return categoryName
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? CategoryViewModel else { return false }
        return self.category == object.category
    }
}
