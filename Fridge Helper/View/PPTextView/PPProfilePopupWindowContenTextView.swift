//
//  PPProfilePopupWindowContenTextView.swift
//  Fridge Helper
//
//  Created by Penn on 24/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPProfilePopupWindowContenTextView: UITextView {

    init() {
        super.init(frame: .zero, textContainer: .none)
        textAlignment = .left
        font = .systemFont(ofSize: 16)
        isEditable = false
        frame = CGRect.PPProfilePopupWindowContenTextViewFrame
        // Switch theme
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
            self.backgroundColor = UIColor.PPTextView.PPProfilePopupWindowContenTextViewBackgroundColor.light
        } else {
            self.backgroundColor = UIColor.PPTextView.PPProfilePopupWindowContenTextViewBackgroundColor.dark        }
    }
}
