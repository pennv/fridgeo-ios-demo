//
//  PPProfilePopupView.swift
//  Fridge Helper
//
//  Created by Penn on 24/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class PPProfilePopupWindowView: PPPopupWindowView {

    var selectedDay: Int?
    var fridgeItemsToDisplay: [[NSDictionary]]?
    
    let today = Calendar(identifier: .gregorian).component(.day, from: Date())
    let currentMonthName = DateFormatter().monthSymbols[Calendar(identifier: .gregorian).component(.month, from: Date()) - 1]
    let lastDayOfMonth = Calendar(identifier: .gregorian).range(of: .day, in: .month, for: Date())!.count
    
    let previousButton = PPProfilePopupWindowPreviousButton()
    let nextButton = PPProfilePopupWindowNextButton()
    
    let titleLabel = PPProfilePopupWindowTitleLabel()
    let subitleLabel = PPProfilePopupWindowSubtitleLabel()
    let contentTextView = PPProfilePopupWindowContenTextView()
    
    init(selectedDay: Int, fridgeItemsToDisplay: [[NSDictionary]]) {
        super.init()
        // Load data
        self.selectedDay = selectedDay
        self.fridgeItemsToDisplay = fridgeItemsToDisplay
        // Update content of popup window
        self.updateContent()
        // Setup buttons
        self.previousButton.addTarget(self, action: #selector(onPreviousButtonClicked), for: .touchUpInside)
        self.nextButton.addTarget(self, action: #selector(onNextButtonClicked), for: .touchUpInside)
        // Add subviews
        addSubview(titleLabel)
        addSubview(subitleLabel)
        addSubview(contentTextView)
        addSubview(previousButton)
        addSubview(nextButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onPreviousButtonClicked() {
        if self.selectedDay == 1 { self.shake();UIDevice.vibrateOnError() }
        let previousSelectedDay = self.selectedDay
        while self.selectedDay! > 1 {
            self.selectedDay! -= 1
            if self.fridgeItemsToDisplay![self.selectedDay! - 1].count > 0 {
                UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                    self.frame.origin.x = -CGFloat.PPPopupWindowViewWidth
                    self.alpha = 0
                }, completion: { _ in
                    self.updateContent()
                    self.frame.origin.x = CGFloat.width
                    UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                        self.frame.origin.x = CGFloat.PPPopupWindowViewPositionX
                        self.alpha = 1
                    })
                })
                return
            }
            if selectedDay == 1 {
                self.shake()
                UIDevice.vibrateOnError()
                self.selectedDay = previousSelectedDay
                return
            }
        }
    }
    
    @objc func onNextButtonClicked() {
        if self.selectedDay == lastDayOfMonth { self.shake();UIDevice.vibrateOnError() }
        let previousSelectedDay = self.selectedDay
        while self.selectedDay! < lastDayOfMonth {
            self.selectedDay! += 1
            if self.fridgeItemsToDisplay![self.selectedDay! - 1].count > 0 {
                UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                    self.frame.origin.x = CGFloat.width
                    self.alpha = 0
                }, completion: { _ in
                    self.updateContent()
                    self.frame.origin.x = -CGFloat.PPPopupWindowViewWidth
                    UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                        self.frame.origin.x = CGFloat.PPPopupWindowViewPositionX
                        self.alpha = 1
                    })
                })
                break
            }
            if self.selectedDay == lastDayOfMonth {
                self.shake()
                UIDevice.vibrateOnError()
                self.selectedDay = previousSelectedDay
                return
            }
        }
    }
    
    func updateContent() {
        // Setup title label
        self.titleLabel.text = currentMonthName + "  " + String(self.selectedDay!)
        // Setup subtitle label
        let days = self.selectedDay! - self.today
        if days > 0 {
            self.subitleLabel.text = "Item(s) expiring in " + String(days) + " day(s)"
        } else if days == 0 {
            self.subitleLabel.text = "Item(s) expires today"
        } else {
            self.subitleLabel.text = "Item(s) expired " + String(-days) + " day(s) ago"
        }
        // Setup content text view
        var contentText = ""
        for item in self.fridgeItemsToDisplay![self.selectedDay! - 1] {
            let nameText = "Name: " + (item.object(forKey: "name") as! String)
            // When category is none
            var categoryText = "\nCategory: "
            let category = item.object(forKey: "category") as? String
            if category == nil || category == "" {
                categoryText += "None\n\n"
            } else { categoryText += category!.capitalizingFirstLetter() + "\n\n" }
            // Remove decimal when it is integer
            var quantityText = "\nQuantity: "
            let quantity = item.object(forKey: "quantity") as! Double
            if floor(quantity) == quantity {
                quantityText += Int(quantity).description
            } else { quantityText += quantity.description }
            contentText +=  nameText + quantityText + categoryText
        }
        self.contentTextView.text = contentText
    }
}
