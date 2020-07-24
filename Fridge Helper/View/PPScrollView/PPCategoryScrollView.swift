//
//  PPCategoryScrollView.swift
//  Fridge Helper
//
//  Created by Penn on 13/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPCategoryScrollView: UIScrollView {
    
    init() {
        super.init(frame: .zero)
        frame = CGRect.PPCategoryScrollViewFrame
        contentSize = CGSize.PPCategoryScrollViewContentSize
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
