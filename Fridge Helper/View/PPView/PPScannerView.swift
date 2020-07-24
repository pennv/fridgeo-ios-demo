//
//  PPScannerView.swift
//  Fridge Helper
//
//  Created by Penn on 10/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit
import AVFoundation

class PPScannerView: UIView, AVCaptureMetadataOutputObjectsDelegate {

    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var delegate: ScannerDelegate?
    
    init() {
        super.init(frame: .zero)
        // Load views
        frame = CGRect(x: 0, y: 0, width: CGFloat.width, height: CGFloat.height)
        let cameraView = UIView(frame: frame)
        insertSubview(cameraView, at: 0)
        let flashlightButton = PPScannerFlashlightButton()
        let scanningFrame = PPScanningFrameImageView()
        let cancelbutton = PPScannerCloseButton()
        cancelbutton.addTarget(self, action: #selector(onCancelButtonTapped), for: .touchUpInside)
        addSubview(scanningFrame)
        addSubview(cancelbutton)
        addSubview(flashlightButton)
        // Load camera layer
        captureSession = AVCaptureSession()
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        let metadataOutput = AVCaptureMetadataOutput()
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
        } else {
            failed()
            return
        }
        
        // Add preview layer
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = frame
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.position = CGPoint(x: frame.width/2, y: frame.height/2)
        
        cameraView.layer.insertSublayer(previewLayer, below: self.layer)
        
        captureSession.startRunning()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Send back the empty string if user decides to cancel the scanning
    @objc func onCancelButtonTapped() {
        delegate?.barcode(["barcode" : nil] as NSDictionary)
    }
    
    
    func found(code: String) {
        delegate?.barcode(["barcode" : code] as NSDictionary)
    }
    
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        UIApplication.shared.windows.first!.rootViewController!.present(ac, animated: true)
        captureSession = nil
    }
    
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: self)
        if newSuperview != nil {
            if (captureSession?.isRunning == false) {
                captureSession.startRunning()
            }
        } else {
            if (captureSession?.isRunning == true) {
                captureSession.stopRunning()
            }
        }
    }
    
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
            return
        }
        
        removeFromSuperview()
    }
}
