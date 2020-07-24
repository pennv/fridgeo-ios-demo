//
//  PPButtonWithResizedImage.swift
//  Fridge Helper
//
//  Created by Penn on 20/5/20.
//  Copyright © 2020 Penn. All rights reserved.
//
/*
   To help resized images swicth between modes
   and set image on init(), as resized image
   instance cannot be changed.
*/

import UIKit

class PPButtonWithResizedImage: UIButton {
    
    var imageName: String?
    var imageSize: CGFloat?
    
    init(imageName: String, imageSize: CGFloat) {
        super.init(frame: .zero)
        self.setImage(UIImage(named: imageName)!.resizeImage(to: imageSize), for: .normal)
        self.imageName = imageName
        self.imageSize = imageSize
    }
    
    func updateImage(imageName: String) {
        self.imageName = imageName
        setImage(UIImage(named: imageName)!.resizeImage(to: imageSize!), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        // Switch theme
        setImage(UIImage(named: imageName!)?.resizeImage(to: imageSize!), for: .normal)
    }
}
