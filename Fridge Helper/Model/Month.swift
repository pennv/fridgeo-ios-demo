//
//  Month.swift
//  Fridge Helper
//
//  Created by Penn on 11/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import Foundation
import IGListKit

final class Month {

    let name: String
    let days: Int

    // day int mapped to an array of appointment names
    let expiringFridgeItems: [Int: Int]

    init(name: String, days: Int, expiringFridgeItems: [Int: Int]) {
        self.name = name
        self.days = days
        self.expiringFridgeItems = expiringFridgeItems
    }

}

extension Month: ListDiffable {
    
    // Derive a unique identifier for each month. Since each month
    // should never have the same name.

    func diffIdentifier() -> NSObjectProtocol {
        return name as NSObjectProtocol
    }
    
    // if two models have the same diffIdentifier, they must be equal
    // so that the section controller can then compare view models.

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
