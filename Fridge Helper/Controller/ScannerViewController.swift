//
//  ScannerViewController.swift
//  Fridge Helper
//
//  Created by Penn on 9/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit
import AVFoundation

protocol ScannerDelegate {
    func barcode(_ item: NSDictionary)
}

class ScannerViewController: PPViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var addButton = PPScannerAddButton()
    var searchButton = PPScannerSearchButton()
    var promptLabel = PPScannerPromptLabel()
    
    var fridgeItemList: [NSDictionary]?
    var isAddButtonSelected: Bool?
    
    var delegate: ScannerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load views
        let cameraView = UIView()
        cameraView.frame = CGRect(x: 0, y: 0, width: CGFloat.width, height: CGFloat.height)
        let flashlightButton = PPScannerFlashlightButton()
        let scanningFrame = PPScanningFrameImageView()
        let cancelbutton = PPScannerCloseButton()
        cancelbutton.addTarget(self, action: #selector(onCancelButtonTapped), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(onSearchButtonTapped), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(onAddButtonTapped), for: .touchUpInside)
        view.addSubview(cameraView)
        view.addSubview(cancelbutton)
        view.addSubview(flashlightButton)
        view.addSubview(scanningFrame)
        view.addSubview(searchButton)
        view.addSubview(addButton)
        view.addSubview(promptLabel)
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
        previewLayer.frame = cameraView.frame
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.position = CGPoint(x: cameraView.frame.width/2, y: cameraView.frame.height/2)
        
        cameraView.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
    
    
    @objc func onAddButtonTapped() {
        isAddButtonSelected = true
        promptLabel.text = "Add new item"
        addButton.setImage(UIImage(named: "add_thick_filled")!.resizeImage(to: CGFloat.PPScannerAddButtonImageSize), for: .normal)
        searchButton.setImage(UIImage(named: "search")!.resizeImage(to: CGFloat.PPScannerSearchButtonImageSize), for: .normal)
        UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {
            self.promptLabel.alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: 0.4, delay: 1, options: [], animations: {
                self.promptLabel.alpha = 0
            })
        })
    }
    
    
    @objc func onSearchButtonTapped() {
        isAddButtonSelected = false
        promptLabel.text = "Find your item"
        addButton.setImage(UIImage(named: "add_thick")!.resizeImage(to: CGFloat.PPScannerAddButtonImageSize), for: .normal)
        searchButton.setImage(UIImage(named: "search_filled")!.resizeImage(to: CGFloat.PPScannerSearchButtonImageSize), for: .normal)
        UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {
            self.promptLabel.alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: 0.4, delay: 1, options: [], animations: {
                self.promptLabel.alpha = 0
            })
        })
    }
    
    
    // Send back the empty string if user decides to cancel the scanning
    @objc func onCancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    
    func found(code: String) {
        // Scanner called by fridge list view controller, or barcode textfield of popup
        guard fridgeItemList != nil else {
            return
        }
        // Check if scanned item exisits
        for item in fridgeItemList! {
            if let barcode = item["barcode"] as? String {
                if barcode != code {
                    continue
                }
                // Item found with the same barcode
                // If user chooses to add item
                if isAddButtonSelected! {
                    delegate?.barcode(["error" : "This item already has been added"] as NSDictionary)
                // If user chooses to search item
                } else {
                    delegate?.barcode(item)
                }
                return
            }
        }
        // Item not found with the same barcode
        // If user chooses to add item
        if isAddButtonSelected! {
            displayLoadingIndicator(message: "Searching barcode...")
            // Ask database and API for barcode name
            db.getBarcodeName(barcode: code) { name, error in
                self.loadingAlert.dismiss(animated: true, completion: {
                    if error == nil && name != nil {
                       self.delegate?.barcode(["name" : name!, "barcode" : code] as NSDictionary)
                    } else {
                        self.delegate?.barcode(["name" : nil, "barcode" : code] as NSDictionary)
                    }
                })
            }
        // If user chooses to search item
        } else {
             delegate?.barcode(["error" : "Item not found"] as NSDictionary)
        }
    }
    
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Get from user default
        isAddButtonSelected = true
        if isAddButtonSelected! {
            onAddButtonTapped()
        } else { onSearchButtonTapped() }
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
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
        
        dismiss(animated: true)
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
