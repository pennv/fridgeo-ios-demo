//
//  SettingViewController.swift
//  Fridge Helper
//
//  Created by Penn on 7/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit

class SettingViewController: PPViewController {
        
    let amountLabel = PPSettingAmountLabel()
    let hideItemLabel = PPSettingHideItemLabel()
    let contactLabel = PPSettingContactLabel()
    let termsLabel = PPSettingTermsLabel()
    let privacyLabel = PPSettingPrivacyLabel()
    let attributionLabel = PPSetingAttributionLabel()
    let logoutButton = PPLogoutButton()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Load views
        navigationItem.title = "Settings"
        amountLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onAmountLabelTapped)))
        contactLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onContactLabelTapped)))
        termsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTermsLabelTapped)))
        privacyLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onPrivacyLabelTapped)))
        attributionLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onAttributionLabelTapped)))
        let hideItemSwitch: UISwitch = {
            let switchButton = UISwitch()
            switchButton.frame = CGRect(x: CGFloat.width*0.8, y: CGFloat.PPSettingHideItemLabelPositionY*1.15, width: CGFloat.width/3, height: CGFloat.PPSettingLabelHeight)
            switchButton.addTarget(self, action: #selector(onHideItemSwitchChanged(_:)), for: .valueChanged)
            let state = UserDefaults.standard.bool(forKey: "hideItemAddedToShoppingList")
            switchButton.setOn(state, animated: false)
            return switchButton
        }()
        view.addSubview(amountLabel)
        view.addSubview(hideItemLabel)
        view.addSubview(hideItemSwitch)
        view.addSubview(contactLabel)
        view.addSubview(termsLabel)
        view.addSubview(privacyLabel)
        view.addSubview(attributionLabel)
        // Observer for login status changed
        NotificationCenter.default.addObserver(self, selector: #selector(onLoginStatusChanged), name: .loginStatusChanged, object: nil)
        // Initial load
        onLoginStatusChanged()
    }
    
    
    override func onThemeChanged() {
        super.onThemeChanged()
        // Change button color on different themes
        navigationItem.leftBarButtonItem = UIBarButtonItem.addBarButton(self, action: #selector(onBackButtonTapped), imageName: "back", heightAnchor: 20, widthAnchor: 20)
    }
    
    
    @objc func onLoginStatusChanged() {
        guard UserDefaults.standard.dictionary(forKey: Key.userProfile) != nil else {
            // Remove logout button
            logoutButton.removeFromSuperview()
            return
        }
        print("FH: user has logged in...")
        // Load logout button
        logoutButton.addTarget(self, action: #selector(onLogoutButtonClicked), for: .touchUpInside)
        view.addSubview(logoutButton)
    }
    
    
    @objc func onAmountLabelTapped() {
        let amountAlertController = UIAlertController(title: "Amount to +/-", message: "", preferredStyle: .alert)
        amountAlertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "(Default is 1)"
            textField.keyboardType = .decimalPad
            let amount = UserDefaults.standard.double(forKey: "amount")
            if amount != 0 {
                if floor(amount) == amount {
                    textField.text = String(Int(amount))
                } else { textField.text = String(amount) }
            } else { textField.text = "1" }
        }
        amountAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        amountAlertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { alert -> Void in
            let textField = amountAlertController.textFields![0] as UITextField
            let amount = Double(textField.text!)
            if (amount != nil && amount! > 0 && amount! <= 99999) || textField.text! == "" {
                UIDevice.vibrateOnSuccess()
                UserDefaults.standard.set(amount, forKey: "amount")
                return
            }
            let alert = UIAlertController(title: "Sorry", message: "Amount must be more than 0 and less than 99999", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            UIDevice.vibrateOnError()
            self.present(alert, animated: true, completion: nil)
        }))
        present(amountAlertController, animated: true, completion: nil)
    }
    
    
    @objc func onHideItemSwitchChanged(_ switchState: UISwitch) {
        if switchState.isOn {
            UserDefaults.standard.set(true, forKey: "hideItemAddedToShoppingList")
        } else{
            UserDefaults.standard.set(false, forKey: "hideItemAddedToShoppingList")
        }
        db.getAllFridgeItems()
    }
    
    
    @objc func onContactLabelTapped() {
        let url = URL(string: "mailto:fridgeohelp@gmail.com")
        UIApplication.shared.open(url!)
    }
    
    
    @objc func onTermsLabelTapped() {
        let termsViewController = PPViewController()
        let termsTextView = UITextView(frame: CGRect(x: 0, y: 0, width: CGFloat.width, height: CGFloat.height*0.95))
        termsTextView.text = Terms().getText()
        termsViewController.view.addSubview(termsTextView)
        present(termsViewController, animated: true, completion: nil)
    }
    
    
    @objc func onPrivacyLabelTapped() {
        let privacyViewController = PPViewController()
        let privacyTextView = UITextView(frame: CGRect(x: 0, y: 0, width: CGFloat.width, height: CGFloat.height*0.95))
        privacyTextView.text = Privacy().getText()
        privacyViewController.view.addSubview(privacyTextView)
        present(privacyViewController, animated: true, completion: nil)
    }
    
    
    @objc func onAttributionLabelTapped() {
        let attributionViewController = PPViewController()
        let attributionTextView = UITextView(frame: CGRect(x: 0, y: 0, width: CGFloat.width, height: CGFloat.height*0.95))
        attributionTextView.text = Attribution().getText()
        attributionViewController.view.addSubview(attributionTextView)
        present(attributionViewController, animated: true, completion: nil)
    }
    
    
    @objc func onLogoutButtonClicked() {
        // Google logout
        GIDSignIn.sharedInstance().signOut()
        // Facebook logout
        LoginManager().logOut()
        // Remove user and notify views
        db.removeUser()
    }
    
    
    @objc func onBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
