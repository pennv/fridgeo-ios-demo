//
//  PPFridgeItemListCellQuantityLabel.swift
//  Fridge Helper
//
//  Created by Penn on 27/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPFridgeItemListCellQuantityLabel: UILabel {

    init() {
    super.init(frame: .zero)
        frame = CGRect.PPFridgeItemListCellQuantityLabelFrame
        textAlignment = .center
        font = .systemFont(ofSize: 21)
        numberOfLines = 1
        self.onThemeChanged()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        // Switch theme
        self.onThemeChanged()
    }
    
    func onThemeChanged() {
        if self.traitCollection.userInterfaceStyle == .light {
            self.layer.addBorder(edge: UIRectEdge.left, color: UIColor.PPLabel.PPFridgeItemListCellLabel.border.light!, thickness: 0.8)
        } else {
            self.layer.addBorder(edge: UIRectEdge.left, color: UIColor.PPLabel.PPFridgeItemListCellLabel.border.dark!, thickness: 0.8)
        }
    }
}
