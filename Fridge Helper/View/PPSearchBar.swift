//
//  PPSearchBar.swift
//  Fridge Helper
//
//  Created by Penn on 13/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPSearchBar: UISearchBar {

    init() {
        super.init(frame: .zero)
        placeholder = "Search"
        searchTextField.layer.masksToBounds = true
        searchTextField.layer.cornerRadius = CGFloat.PPSearchBarCornerRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
