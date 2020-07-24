//
//  PPPurchaseViewControllerTitleLabel.swift
//  Fridgeo
//
//  Created by Penn on 28/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPPurchaseViewControllerTitleLabel: UILabel {

    init() {
        super.init(frame: .zero)
        frame = CGRect.PPPurchaseViewControllerTitleLabelFrame
        textAlignment = .center
        numberOfLines = 1
        let fridgeo = NSAttributedString(string: "Fridgeo ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .light)])
        let pro = NSAttributedString(string: "Pro", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.98, green: 0.84, blue: 0.34, alpha: 1.00).cgColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .heavy)])
        let content = NSMutableAttributedString(attributedString: fridgeo)
        content.append(pro)
        attributedText = content
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
