//
//  PPFridgeItemPopupWindowCategoryPickerView.swift
//  Fridge Helper
//
//  Created by Penn on 29/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

protocol ToolbarPickerViewDelegate: class {
    func didTapDone(_ sender: String)
    func didTapCancel()
}

class PPFridgeItemPopupWindowCategoryPickerView: UIPickerView {
    
    weak var toolbarDelegate: ToolbarPickerViewDelegate?
    let toolBar = UIToolbar()

    init() {
        super.init(frame: .zero)
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelTapped))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        onThemeChanged()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func doneTapped() {
        self.toolbarDelegate?.didTapDone("category")
    }

    @objc func cancelTapped() {
        self.toolbarDelegate?.didTapCancel()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        // Switch theme
        self.onThemeChanged()
    }
    
    func onThemeChanged() {
        if traitCollection.userInterfaceStyle == .light {
            toolBar.tintColor = UIColor.Background.dark
        } else {
            toolBar.tintColor = UIColor.Background.light
        }
    }
}
