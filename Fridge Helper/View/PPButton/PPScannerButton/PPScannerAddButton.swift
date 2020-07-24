//
//  PPScannerAddButton.swift
//  Fridge Helper
//
//  Created by Penn on 10/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPScannerAddButton: UIButton {

    init() {
        super.init(frame: .zero)
        frame = CGRect.PPScannerAddButtonFrame
        setImage(UIImage(named: "add_thick_filled")!.resizeImage(to: CGFloat.PPScannerAddButtonImageSize), for: .normal)
        backgroundColor = UIColor.PPButton.PPScannerButtonBackgroundColor
        roundCorners(topRight: CGFloat.PPScannerAddButtonCorcerRadius, bottomRight: CGFloat.PPScannerAddButtonCorcerRadius)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
