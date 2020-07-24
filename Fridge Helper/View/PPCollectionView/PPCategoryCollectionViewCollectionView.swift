//
//  PPCategoryCollectionView.swift
//  Fridge Helper
//
//  Created by Penn on 17/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit
import IGListKit

class PPCategoryCollectionView: UICollectionView {
    
    init() {
        super.init(frame: .zero, collectionViewLayout: ListCollectionViewLayout(stickyHeaders: false, topContentInset: 0, stretchToEdge: false))
        self.frame = CGRect.PPCategoryCollectionViewFrame
        self.keyboardDismissMode = .onDrag
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
        if traitCollection.userInterfaceStyle == .light {
            self.backgroundColor = UIColor.Background.light
        } else {
            self.backgroundColor = UIColor.Background.dark
        }
    }
}
