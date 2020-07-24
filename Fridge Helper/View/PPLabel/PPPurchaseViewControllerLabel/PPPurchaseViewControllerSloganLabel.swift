//
//  PPPurchaseViewControllerSloganLabel.swift
//  Fridgeo
//
//  Created by Penn on 28/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPPurchaseViewControllerSloganLabel: UILabel {

    init() {
        super.init(frame: .zero)
        frame = CGRect.PPPurchaseViewControllerTitleLabelFrame
        frame.origin.x = CGFloat.width*0.02
        frame.size.width *= 0.96
        frame.origin.y *= 1.2
        frame.size.height *= 2
        textAlignment = .center
        numberOfLines = 4
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 1.5
        let part1 = NSAttributedString(string: "Allows you to store up to\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26, weight: .light)])
        let part2 = NSAttributedString(string: "1000 ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 28, weight: .heavy)])
        let part3 = NSAttributedString(string: "fridge items on cloud", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26, weight: .light)])
        let part4 = NSAttributedString(string: "\n2 Weeks FREE Trial for Annual Plan now!", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .light), NSAttributedString.Key.foregroundColor: UIColor.gray])
        let content = NSMutableAttributedString(attributedString: part1)
        content.append(part2)
        content.append(part3)
        content.append(part4)
        attributedText = content
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
