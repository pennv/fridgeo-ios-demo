//
//  DayViewModel.swift
//  Fridge Helper
//
//  Created by Penn on 11/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import Foundation
import IGListKit

final class DayViewModel {

    let day: Int
    let today: Bool
    let selected: Bool
    let expiredFridgeItems: Int

    init(day: Int, today: Bool, selected: Bool, expiredFridgeItems: Int) {
        self.day = day
        self.today = today
        self.selected = selected
        self.expiredFridgeItems = expiredFridgeItems
    }

}

extension DayViewModel: ListDiffable {

    func diffIdentifier() -> NSObjectProtocol {
        return day as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? DayViewModel else { return false }
        return today == object.today && selected == object.selected && expiredFridgeItems == object.expiredFridgeItems
    }

}
