//
//  PPScanningFrameImageView.swift
//  Fridge Helper
//
//  Created by Penn on 10/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPScanningFrameImageView: UIImageView {

    init() {
        super.init(frame: .zero)
        frame = CGRect.PPScanningFrameImageViewFrame
        image = UIImage(named: "scanning_frame")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
