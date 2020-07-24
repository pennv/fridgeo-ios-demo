//
//  PPScannerPromptLabel.swift
//  Fridge Helper
//
//  Created by Penn on 10/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPScannerPromptLabel: UILabel {

    init() {
        super.init(frame: .zero)
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 14)
        textColor = .white
        frame = CGRect.PPScannerPromptLabelFrame
        backgroundColor = UIColor.PPButton.PPScannerButtonBackgroundColor
        roundCorners(topLeft: CGFloat.PPScannerPromptLabelCorcerRadius, topRight: CGFloat.PPScannerPromptLabelCorcerRadius, bottomLeft: CGFloat.PPScannerPromptLabelCorcerRadius, bottomRight: CGFloat.PPScannerPromptLabelCorcerRadius)
        numberOfLines = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
