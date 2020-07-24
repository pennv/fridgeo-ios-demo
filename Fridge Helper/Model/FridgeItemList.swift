//
//  FridgeItemList.swift
//  Fridge Helper
//
//  Created by Penn on 26/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit
import IGListKit

final class FridgeItemList {
    
    let list: [NSDictionary]

    init(list: [NSDictionary]) {
        self.list = list
    }
}

extension FridgeItemList: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return "fridgeItemList" as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }
}
