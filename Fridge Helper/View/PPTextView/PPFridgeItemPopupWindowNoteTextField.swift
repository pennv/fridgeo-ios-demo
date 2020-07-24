//
//  PPFridgeItemPopupWindowNoteTextField.swift
//  Fridge Helper
//
//  Created by Penn on 29/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPFridgeItemPopupWindowNoteTextView: UITextView {

    init() {
        super.init(frame: .zero, textContainer: .none)
        textAlignment = .left
        font = UIFont.systemFont(ofSize: 16)
        frame = CGRect.PPFridgeItemPopupWindowTextFieldFrame
        frame.origin.y = CGFloat.PPFridgeItemPopupWindowNoteTextFieldPositionY
        frame.size.height = CGFloat.PPFridgeItemPopupWindowNoteTextFieldHeight
        layer.borderWidth = 0.6
        layer.borderColor = UIColor.gray.cgColor
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
            self.backgroundColor = UIColor.PPTextView.PPProfilePopupWindowContenTextViewBackgroundColor.light
        } else {
            self.backgroundColor = UIColor.PPTextView.PPProfilePopupWindowContenTextViewBackgroundColor.dark
        }
    }
}
