//
//  PPScannerFlashlightButton.swift
//  Fridge Helper
//
//  Created by Penn on 10/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit
import AVFoundation

class PPScannerFlashlightButton: UIButton {

    init() {
        super.init(frame: .zero)
        frame = CGRect.PPScannerFlashlightButtonFrame
        setImage(UIImage(named: "flashlight")!.resizeImage(to: CGFloat.PPScannerFlashlightButtonImageSize), for: .normal)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onFlashlightButtonTapped)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onFlashlightButtonTapped() {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video)
            else { return }
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                if !device.isTorchActive {
                    device.torchMode = .on
                    setImage(UIImage(named: "flashlight_filled")!.resizeImage(to: CGFloat.PPScannerFlashlightButtonImageSize), for: .normal)
                }
                else {
                    device.torchMode = .off
                    setImage(UIImage(named: "flashlight")!.resizeImage(to: CGFloat.PPScannerFlashlightButtonImageSize), for: .normal)
                }
                device.unlockForConfiguration()
            } catch {
                print("FH: torch could not be used...")
            }
        } else {
            print("FH: torch is not available...")
        }
    }
}
