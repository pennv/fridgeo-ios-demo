//
//  PPSpinner.swift
//  Fridge Helper
//
//  Created by Penn on 31/3/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPSpinner: UIActivityIndicatorView {
    
    init() {
        // The frame is determained by style so the input frame is
        // only to be compitable with parent class and will be ignored.
        super.init(frame: CGRect.titleLabelFrame)
        style = .large
        center = CGPoint.PPSpinnerPosition
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
