//
//  SceneDelegate.swift
//  Fridge Helper
//
//  Created by Penn on 22/3/20.
//  Copyright © 2020 Penn. All rights reserved.
//

/*

   The network and login status will be checked on initial load.
   Afterwards the observers: Reachability and loginStatusChanged
   will determine the root view on status change.
 
*/

import UIKit
import GoogleSignIn
import FBSDKCoreKit
import Reachability
import SwiftyStoreKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var loadingAlert: UIAlertController?
    
    var currentTheme: UIUserInterfaceStyle?
    
    let reachability = try! Reachability()
    var reachable: Bool = false
    
    let sharedSecret = "5eef65d80e184b7badc967164ec38eef"
    let products = ["penn.fridgeo.purchase.oneMonth", "penn.fridgeo.purchase.oneYear"]

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        // Setup root view controller without main storyboard
        let windowScene = UIApplication.shared.connectedScenes.first
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene as? UIWindowScene
        // Continue displaying launch screen until root view determined
        window?.rootViewController = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateViewController(withIdentifier: "LaunchScreenViewController")
        window?.makeKeyAndVisible()
        // Observer for login status change
        NotificationCenter.default.addObserver(self, selector: #selector(onNetworkOrLoginStatusChanged), name: .loginStatusChanged, object: nil)
        // Initial check on login status
        checkNetworkStatus()
    }
    
    func checkNetworkStatus() {
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("FH: reachable via WiFi...")
            } else if reachability.connection == .cellular {
                print("FH: reachable via Cellular...")
            } else {
                print("FH: reachable via unknown method...")
            }
            // Reload view only on switching from unreachable to
            // reachable instead of from wifi to cellular or vice varsa
            if !self.reachable {
                self.reachable = true
                self.onNetworkOrLoginStatusChanged()
            }
        }
        reachability.whenUnreachable = { _ in
            print("FH: not reachable...")
            self.reachable = false
            self.onNetworkOrLoginStatusChanged()
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("FH: unable to start notifier...")
            self.reachable = false
            self.onNetworkOrLoginStatusChanged()
        }
    }
    
    @objc func onNetworkOrLoginStatusChanged() {
        if !reachable {
            let notReachableViewController = NotReachableViewController()
            window?.rootViewController = notReachableViewController
            window?.makeKeyAndVisible()
            return
        }
        // If user has not logged in, change root view to login view
        guard UserDefaults.standard.dictionary(forKey: Key.userProfile) == nil else {
            // If user has logged in, change root view to tabbar view.
            // If switch user, the tabbar and sub views will be re-built
            let tabBarViewController = TabBarViewController()
            self.window?.rootViewController = tabBarViewController
            self.window?.makeKeyAndVisible()
            return
        }
        let loginViewController = LoginViewController()
        let navigatedLoginViewController = PPNavigationController()
        navigatedLoginViewController.viewControllers = [loginViewController]
        navigatedLoginViewController.modalTransitionStyle = .coverVertical
        navigatedLoginViewController.modalPresentationStyle = .overFullScreen
        window?.rootViewController = navigatedLoginViewController
        window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        // Handle login returned from native facebook app
        if let openURLContext = URLContexts.first {
            ApplicationDelegate.shared.application(UIApplication.shared, open: openURLContext.url, sourceApplication: openURLContext.options.sourceApplication, annotation: openURLContext.options.annotation)
        }
    }
    
    

//    func sceneDidDisconnect(_ scene: UIScene) {
//        // Called as the scene is being released by the system.
//        // This occurs shortly after the scene enters the background, or when its session is discarded.
//        // Release any resources associated with this scene that can be re-created the next time the scene connects.
//        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
//    }
//
//    func sceneDidBecomeActive(_ scene: UIScene) {
//        // Called when the scene has moved from an inactive state to an active state.
//        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
////        if window?.traitCollection.userInterfaceStyle != currentTheme {
////            currentTheme = window?.traitCollection.userInterfaceStyle
////            let userInfo = ["theme": currentTheme!] as [AnyHashable : Any]
////            NotificationCenter.default.post(name: .themeChanged, object: self, userInfo: userInfo)
////            return
////        }
//    }
//
//    func sceneWillResignActive(_ scene: UIScene) {
//        // Called when the scene will move from an active state to an inactive state.
//        // This may occur due to temporary interruptions (ex. an incoming phone call).
//    }
//
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        guard let userProfile = UserDefaults.standard.dictionary(forKey: Key.userProfile) as NSDictionary? else {
            print("FH: user has not logged in...")
            return
        }
        // If there is a expire date in profile (user has purchase history)
        guard let expireDateString = userProfile.object(forKey: "expire") as? String else {
            print("FH: user never purchased...")
            return
        }
        // Compare expiry date and current date, and both of them are in UTC format
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let expireDate = formatter.date(from: expireDateString) else {
            print("FH: ilegal date format")
            return
        }
        let now = Date()
        if expireDate > now {
            print("FH: user purchase has not expired...")
            return
        }
        print("FH: user purchase expired...")
        guard let purchaseQuantity = userProfile.object(forKey: "purchase") as? Int else {
            print("FH: error on user purchase quantity...")
            return
        }
        if purchaseQuantity <= 10 {
            print("FH: user did not renew the subscription...")
            return
        }
        print("FH: check if user has successfully renewed...")
        let id = userProfile.object(forKey: "id") as! String
        db.purchase(id: id) { error in
            if error != nil {
                print("FH: \(error!)")
            } else { print("FH: user has renewed and updated expiry date has been saved on device...") }
        }
    }
    
    func displayLoadingIndicator(message: String? = nil) {
        loadingAlert = UIAlertController(title: nil, message: message ?? "", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()
        loadingAlert!.view.addSubview(loadingIndicator)
        window?.rootViewController?.present(loadingAlert!, animated: true, completion: nil)
    }
    
    func displayAlert(name: String, message: String) {
        let alertController = UIAlertController(title: name, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style:
            UIAlertAction.Style.default,handler: nil))
        // Present alert from the root view controller
        UIApplication.shared.windows.first!.rootViewController!.present(alertController, animated: true, completion: nil)
        print("FH: alert \"", name, "\" has been displayed...")
    }
//
//    func sceneDidEnterBackground(_ scene: UIScene) {
//        // Called as the scene transitions from the foreground to the background.
//        // Use this method to save data, release shared resources, and store enough scene-specific state information
//        // to restore the scene back to its current state.
//    }


}

