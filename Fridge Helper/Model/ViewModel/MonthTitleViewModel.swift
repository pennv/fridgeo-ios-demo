//
//  MonthTitleViewModel.swift
//  Fridge Helper
//
//  Created by Penn on 11/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import Foundation
import IGListKit

final class MonthTitleViewModel {

    let name: String

    init(name: String) {
        self.name = name
    }

}

extension MonthTitleViewModel: ListDiffable {

    func diffIdentifier() -> NSObjectProtocol {
        return name as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard object is MonthTitleViewModel else { return false }
        // name is checked in the diffidentifier, so we can assume its equal
        return true
    }

}
