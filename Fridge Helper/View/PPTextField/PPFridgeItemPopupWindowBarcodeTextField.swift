//
//  PPFridgeItemPopupWindowBarcodeTextField.swift
//  Fridge Helper
//
//  Created by Penn on 29/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPFridgeItemPopupWindowBarcodeTextField: UITextField, ScannerDelegate {
    
    lazy fileprivate var scanner = PPScannerView()

    init() {
        super.init(frame: .zero)
        frame = CGRect.PPFridgeItemPopupWindowTextFieldFrame
        frame.origin.y = CGFloat.PPFridgeItemPopupWindowBarcodeTextFieldPositionY
        font = UIFont.boldSystemFont(ofSize: 18)
        placeholder = "Tap to scan scan barcode"
        borderStyle = .none
        clearButtonMode = .whileEditing
        addTarget(self, action: #selector(onTextFieldTapped), for: .allEvents)
        //layer.addBorder(edge: .bottom, color: .gray, thickness: 0.6)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onTextFieldTapped() {
        resignFirstResponder()
        scanner.delegate = self
        scanner.frame.origin.y = CGFloat.height
        superview?.superview?.superview?.addSubview(scanner)
        superview?.superview?.superview?.bringSubviewToFront(scanner)
        UIView.animate(withDuration: 0.6, delay: 0, options: [], animations: {
            self.scanner.frame.origin.y = 0
        })
    }
    
    func barcode(_ item: NSDictionary) {
        if let barcode = item["barcode"] as? String {
            text = barcode
        }
        UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {
            self.scanner.frame.origin.y = CGFloat.height
        }, completion: { _ in
            self.scanner.frame.origin.y = 0
            self.scanner.removeFromSuperview()
        })
    }
}
