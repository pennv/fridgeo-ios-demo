//
//  AppDelegate.swift
//  Fridge Helper
//
//  Created by Penn on 22/3/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKCoreKit

let db = DatabaseController()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var GOOGLE_CLIENT_ID = "450466782088-mkvleohuuhempm7biuce92ji5jj0ua2a.apps.googleusercontent.com"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Configure google login
        GIDSignIn.sharedInstance().clientID = GOOGLE_CLIENT_ID
        
        // Configure facebook login
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // Return URL schema based on by login method
        return (GIDSignIn.sharedInstance().handle(url) || ApplicationDelegate.shared.application(app, open: url, options: options))
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

