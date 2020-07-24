//
//  FridgeItemViewModel.swift
//  Fridge Helper
//
//  Created by Penn on 26/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit
import IGListKit

class FridgeItemViewModel {
    
    let _id: String
    let name: String
    let quantity: Double
    let list: Int
    let need: Double?
    let category: String?
    let date: String?
    let barcode: String?
    let note: String?
    
    init(_id: String, name: String, quantity: Double, list: Int, need: Double?, category: String?, date: String?, barcode: String?, note: String?) {
        self._id = _id
        self.name = name
        self.quantity = quantity
        self.list = list
        self.need = need
        self.category = category
        self.date = date
        self.barcode = barcode
        self.note = note
    }
}

extension FridgeItemViewModel: ListDiffable {

    func diffIdentifier() -> NSObjectProtocol {
        return _id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? FridgeItemViewModel else { return false }
        return _id == object._id
    }

}
