//
//  NotReachableViewController.swift
//  Fridge Helper
//
//  Created by Penn on 16/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit

class NotReachableViewController: PPViewController {
    
    let notReachableLabel = PPNotReachableLabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadLabel()
    }
    
    func loadLabel() {
        view.addSubview(notReachableLabel)
    }
}
