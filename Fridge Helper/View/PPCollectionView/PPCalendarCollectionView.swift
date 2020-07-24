//
//  PPCalendarCollectionView.swift
//  Fridge Helper
//
//  Created by Penn on 11/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit
import IGListKit

class PPCalendarCollectionView: UICollectionView {
    
    init() {
        super.init(frame: .zero, collectionViewLayout: ListCollectionViewLayout(stickyHeaders: false, topContentInset: 0, stretchToEdge: false))
        collectionViewLayout = ListCollectionViewLayout(stickyHeaders: false, topContentInset: 0, stretchToEdge: false)
        self.frame = CGRect.PPCalendarCollectionViewFrame
        self.layer.cornerRadius = CGFloat.PPCalendarCollectionViewCornerRadius
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
            self.backgroundColor = UIColor.PPCell.CalendarDayCellBackgroundColor.light
        } else {
            self.backgroundColor = UIColor.PPCell.CalendarDayCellBackgroundColor.dark
        }
    }
}
