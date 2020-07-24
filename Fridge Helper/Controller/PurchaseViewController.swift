//
//  PurchaseViewController.swift
//  Fridge Helper
//
//  Created by Penn on 26/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit
import StoreKit
import SwiftyStoreKit
import Alamofire

class PurchaseViewController: PPViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    var products: [SKProduct]?
    
    let monthlyProductId = "penn.fridgeo.purchase.oneMonth"
    let yearlyProductId = "penn.fridgeo.purchase.oneYear"
    
    let sharedSecret = "5eef65d80e184b7badc967164ec38eef"
    
    let monthlyBuyButton = PPPurchaseViewControllerMonthBuyButton()
    let yearlyBuyButton = PPPurchaseViewControllerYearBuyButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPurchaseView()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if products != nil { return }
        // Fetch in-app purchase products
        displayLoadingIndicator(message: "Loading...")
        let request = SKProductsRequest(productIdentifiers: Set([monthlyProductId, yearlyProductId]))
        request.delegate = self
        request.start()
    }
    
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async {
            // Dismiss loading indicator
            self.loadingAlert.dismiss(animated: true, completion: {
                // Dismiss purchase view controller if no products fetched
                if response.products.count <= 0 { self.dismiss(animated: true, completion: {
                    print("FH: no products fetched from app store...")
                    self.displayAlert(name: "Error", message: "Unable to fetch purchase info, please try again later")
                })} else {
                    self.products = response.products
                    self.monthlyBuyButton.setTitle("Monthly Plan  " + self.products![0].localizedPrice! + "/Month", for: .normal)
                    self.yearlyBuyButton.setTitle("Annual Plan  " + self.products![1].localizedPrice! + "/Year", for: .normal)
                }
            })
        }
    }
    
    
    @objc func buyButtonTapped(_ button: UIButton) {
        guard products != nil else {
            if products == nil { self.dismiss(animated: true, completion: {
                self.displayAlert(name: "Error", message: "Unable to fetch purchase info, please try again later")
            })}
            return
        }
        if !SKPaymentQueue.canMakePayments() {
            self.displayAlert(name: "Unable to pay", message: "Please try again later")
            return
        }
        displayLoadingIndicator(message: "Loading...")
        var product: [SKProduct] = []
        if let _ = button as? PPPurchaseViewControllerMonthBuyButton {
            product = products!.filter{ ($0 as SKProduct).productIdentifier == monthlyProductId }
        } else if let _ = button as? PPPurchaseViewControllerYearBuyButton {
            product = products!.filter{ ($0 as SKProduct).productIdentifier == yearlyProductId }
        }
        let payment = SKPayment(product: product[0])
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(payment)
    }
    
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .deferred, .purchasing:
                break
            case .restored:
                // Currently users cannot access to restore function
                print("FH: purchase restored...")
                SKPaymentQueue.default().finishTransaction(transaction)
                break
            case .failed:
                if let error = transaction.error as? SKError {
                    if error.code != .paymentCancelled {
                        print("FH: purchase failed - \(error.localizedDescription)...")
                    } else {
                        print("FH: purchase cancelled - \(error.localizedDescription)...")
                    }
                    loadingAlert.dismiss(animated: true, completion: {
                        self.dismiss(animated: true, completion: {
                            self.displayAlert(name: "Error", message: error.localizedDescription)
                        })
                    })
                }
                SKPaymentQueue.default().finishTransaction(transaction)
                break
            case .purchased:
                SwiftyStoreKit.fetchReceipt(forceRefresh: true) { result in
                    switch result {
                    case .success(let receiptData):
                        let encryptedReceipt = receiptData.base64EncodedString(options: [])
                        print("FH: fetch receipt success...")
                        let userProfile = UserDefaults.standard.dictionary(forKey: Key.userProfile)! as NSDictionary
                        let id = userProfile.object(forKey: "id") as! String
                        db.purchase(id: id, receipt: encryptedReceipt) { error in
                            if error != nil {
                                self.loadingAlert.dismiss(animated: true, completion: {
                                    self.dismiss(animated: true, completion: {
                                        self.displayAlert(name: "Error", message: error!)
                                    })
                                })
                            } else {
                                self.loadingAlert.dismiss(animated: true, completion: {
                                    // Dismiss purchase view
                                    self.dismiss(animated: true, completion: {
                                        SKStoreReviewController.requestReview()
                                    })
                                })
                            }
                        }
                    case .error(let error):
                        print("FH: fetch receipt failed - \(error)")
                        self.loadingAlert.dismiss(animated: true, completion: {
                            self.dismiss(animated: true, completion: {
                                self.displayAlert(name: "Error", message: error.localizedDescription)
                            })
                        })
                    }
                }
                break
            @unknown default:
                loadingAlert.dismiss(animated: true, completion: {
                    self.dismiss(animated: true, completion: {
                        self.displayAlert(name: "Unknown error", message: "Please try again later")
                        print("FH: unknown error happened in purchase...")
                    })
                })
                break
            }
        }
    }
    
    
    @objc func onTermsLabelTapped() {
        let notesViewController = PPViewController()
        let notesTextView = UITextView(frame: CGRect(x: 0, y: 0, width: CGFloat.width, height: CGFloat.height*0.95))
        notesTextView.text = "**Purchase Notes**\n\nYour access to 1000 fridge items starts as soon as you setup payment and subscribe with iTunes. Your monthly or yearly charge will occur on the last day of the current billing period. We will renew your memebership for you (unless auto renew is turned-off 24 hours before the end of your billing cycle. Once your purchase is successful, you can manage your subscription or turn off auto-renewal under Account Settings. By continuing, you are agreeing to Terms & Conditions and Privacy which you can find in app's setting view"
        notesViewController.view.addSubview(notesTextView)
        present(notesViewController, animated: true, completion: nil)
    }
    
    
    @objc func onRestoreLabelTapped() {
        displayLoadingIndicator(message: "Loading...")
        let userProfile = UserDefaults.standard.dictionary(forKey: Key.userProfile)! as NSDictionary
        let id = userProfile.object(forKey: "id") as! String
        db.purchase(id: id) { error in
            self.dismiss(animated: true, completion: {
                self.dismiss(animated: true, completion: {
                    if error != nil {
                        self.displayAlert(name: "Error", message: error!)
                    } else {
                        self.displayAlert(name: "Success", message: "Your purchase has been restored")
                    }
                })
            })
        }
    }
    
    
    @objc func onCloseButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    
    func loadPurchaseView() {
        // Setup scroll view
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: CGFloat.width, height: CGFloat.height))
        scrollView.contentSize = CGSize(width: CGFloat.width, height: CGFloat.height*1.3)
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        // Setup view
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: CGFloat.width, height: UINavigationController().navigationBar.frame.size.height))
        navbar.backgroundColor = .clear
        navbar.isTranslucent = true
        navbar.setBackgroundImage(UIImage(), for: .default)
        navbar.shadowImage = UIImage()
        let navItem = UINavigationItem()
        let closeButton = PPPurchaseViewControllerCloseBarButton()
        closeButton.addTarget(self, action: #selector(onCloseButtonTapped), for: .touchUpInside)
        navItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)
        navbar.items = [navItem]
        let crownImage = PPPurchaseViewControllerCrownImageView()
        let profileImage = PPPurchaseViewControllerLogoImageView()
        let restoreLabel = PPPurchaseViewControllerRestoreLabel()
        let titleLabel = PPPurchaseViewControllerTitleLabel()
        let sloganLabel = PPPurchaseViewControllerSloganLabel()
        let termsLabel = PPPurchaseViewControllerTermsLabel()
        monthlyBuyButton.addTarget(self, action: #selector(buyButtonTapped(_:)), for: .touchUpInside)
        yearlyBuyButton.addTarget(self, action: #selector(buyButtonTapped(_:)), for: .touchUpInside)
        restoreLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onRestoreLabelTapped)))
        view.addSubview(navbar)
        scrollView.addSubview(crownImage)
        scrollView.addSubview(profileImage)
        scrollView.addSubview(restoreLabel)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(sloganLabel)
        scrollView.addSubview(monthlyBuyButton)
        scrollView.addSubview(yearlyBuyButton)
        scrollView.addSubview(termsLabel)
        scrollView.bringSubviewToFront(termsLabel)
        scrollView.bringSubviewToFront(restoreLabel)
    }
}
