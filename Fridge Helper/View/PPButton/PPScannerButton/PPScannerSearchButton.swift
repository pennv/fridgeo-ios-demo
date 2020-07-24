//
//  PPScannerSearchButton.swift
//  Fridge Helper
//
//  Created by Penn on 10/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPScannerSearchButton: UIButton {

    init() {
        super.init(frame: .zero)
        frame = CGRect.PPScannerSearchButtonFrame
        setImage(UIImage(named: "search")!.resizeImage(to: CGFloat.PPScannerSearchButtonImageSize), for: .normal)
        backgroundColor = UIColor.PPButton.PPScannerButtonBackgroundColor
        roundCorners(topLeft: CGFloat.PPScannerSearchButtonCornerRadius, bottomLeft: CGFloat.PPScannerSearchButtonCornerRadius)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
