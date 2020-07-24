//
//  LoginViewController.swift
//  Fridge Helper
//
//  Created by Penn on 4/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

/*
 
    When login status changed, the scene will determine the root
    view so this view don't need to be dismissed manually and its
    task is to show the view and display the login error
 
 */

import UIKit
import FBSDKLoginKit
import GoogleSignIn
import AuthenticationServices

class LoginViewController: PPViewController, GIDSignInDelegate, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    let googleLoginButton = PPGoogleLoginButton()
    let facebookLoginButton = PPFacebookLoginButton()
    let appleLoginButton = PPAppleLoginButton()
    let sloganLabel = PPSloganLabel()
    let spinner = PPSpinner()
    
    
    
    // MARK: Logic
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load login view
        self.loadLoginView()
        // Observer for login status changed
        NotificationCenter.default.addObserver(self, selector: #selector(onLoginStatusChanged(_:)), name: .loginStatusChanged, object: nil)
    }
    
    @objc func onLoginStatusChanged(_ notification: Notification) {
        self.spinner.stopAnimating()
        let error = notification.userInfo?["error_login"] as? String
        if error != nil {
            self.displayAlert(name: "Failed to Sign-in", message: error!)
        }
    }
    
    // Facebook login button onClick action and callback
    @objc func onFacebookLoginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) -> Void in
            print("FH: user attempts to login by facebook...")
            guard result?.isCancelled == false else {
                // If login was canceled or interrupted
                print("FH: user failed to login...")
                return
            }
            self.spinner.startAnimating()
            db.getUser(method: "facebook", id: (result?.token!.userID)!, token: (result?.token!.tokenString)!)
        }
    }
    
    // Google login button onClick action
    @objc func onGoogleLoginButtonClicked() {
        GIDSignIn.sharedInstance().signIn()
    }
    // Google login callback
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("FH: user attempts to login by google...")
        guard user?.authentication.idToken != nil else {
            // If login was canceled or interrupted
            print("FH: user failed to login...")
            return
        }
        self.spinner.startAnimating()
        db.getUser(method: "google", id: user.userID, token: (user?.authentication.idToken)!)
    }
    
    // Apple login button onClick action
    @objc func onAppleLoginButtonClicked() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            // Create an account in your system.
            let id = appleIDCredential.user
            let name = (appleIDCredential.fullName?.givenName ?? "Apple") + " " + (appleIDCredential.fullName?.familyName ?? "User")
            let email = appleIDCredential.email
            self.spinner.startAnimating()
            db.getUser(method: "apple", id: id, token: id, name: name, email: email)
        default:
            break
        }
    }
    
    
    
    // MARK: View
    
    
    
    func loadLoginView() {
        // Load Facebook login button
        facebookLoginButton.addTarget(self, action: #selector(onFacebookLoginButtonClicked), for: .touchUpInside)
        view.addSubview(facebookLoginButton)
        // Load Google login button
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        googleLoginButton.addTarget(self, action: #selector(onGoogleLoginButtonClicked), for: .touchUpInside)
        view.addSubview(googleLoginButton)
        // Load Apple login button
        appleLoginButton.addTarget(self, action: #selector(onAppleLoginButtonClicked), for: .touchUpInside)
        view.addSubview(appleLoginButton)
        // Setup spinner
        view.addSubview(spinner)
        // Load text label
        view.addSubview(sloganLabel)
    }
}
