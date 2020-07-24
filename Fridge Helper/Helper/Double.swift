//
//  Double.swift
//  Fridge Helper
//
//  Created by Penn on 1/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

extension Double {
    func rounded(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return (self * multiplier).rounded() / multiplier
    }
}
