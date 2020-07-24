//
//  PPViewController.swift
//  Fridge Helper
//
//  Created by Penn on 7/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPViewController: UIViewController {
    
    var loadingAlert = UIAlertController()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.onThemeChanged()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        // Switch theme
        self.onThemeChanged()
    }
    
    func onThemeChanged() {
        if traitCollection.userInterfaceStyle == .light {
            view.backgroundColor = UIColor.Background.light
        } else {
            view.backgroundColor = UIColor.Background.dark
        }
    }
    
    func displayLoadingIndicator(message: String? = nil) {
        loadingAlert = UIAlertController(title: nil, message: message ?? "", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()
        loadingAlert.view.addSubview(loadingIndicator)
        present(loadingAlert, animated: true, completion: nil)
    }
    
    func displayAlert(name: String, message: String) {
        let alertController = UIAlertController(title: name, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style:
            UIAlertAction.Style.default,handler: nil))
        // Present alert from the root view controller
        UIApplication.shared.windows.first!.rootViewController!.present(alertController, animated: true, completion: nil)
        print("FH: alert \"", message, "\" has been displayed...")
    }
}
