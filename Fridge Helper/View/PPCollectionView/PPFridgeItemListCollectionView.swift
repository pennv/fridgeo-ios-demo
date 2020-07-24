//
//  PPFridgeItemListCollectionView.swift
//  Fridge Helper
//
//  Created by Penn on 26/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit
import IGListKit

class PPFridgeItemListCollectionView: UICollectionView {
    
    init() {
        super.init(frame: .zero, collectionViewLayout: ListCollectionViewLayout(stickyHeaders: false, topContentInset: 0, stretchToEdge: false))
        frame = CGRect.PPFridgeItemListCollectionViewFrame
        showsVerticalScrollIndicator = true
        //scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -10)
        onThemeChanged()
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
        if traitCollection.userInterfaceStyle == .light {
            self.backgroundColor = UIColor.Background.light
        } else {
            self.backgroundColor = UIColor.Background.dark
        }
    }
}
