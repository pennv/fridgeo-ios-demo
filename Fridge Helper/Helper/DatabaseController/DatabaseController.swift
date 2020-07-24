//
//  DatabaseController.swift
//  Fridge Helper
//
//  Created by Penn on 30/3/20.
//  Copyright © 2020 Penn. All rights reserved.
//

/*
 
    * GET *
 
    Views are able to simply get data by just calling following methods
    and the result would be returned accordingly by two observers:
    dataUpdated and loginStatusChanged. When method getAllFridgeItems
    is invoked at first time, database controller would request the data
    from server and save it as a local variable, so by next time this
    method is invoked, the fridge items data will be directly sent to
    caller from local varible via the observer dataUpdated.
    Observer loginStatusChanged will be invoked without any information
    but error message so views need to determine login status by themselves
    by retriving user profile from UserDefault.
 
    * CRUD *
 
    When the CRUD methods are invoked with modified data as parameter,
    following CRUD methods would immediatly send the modified data back
    to views through observer dataUpdated and start to send the request
    to the server at the same time. Therefore, if server returens
    successful message, there is no any other actions required except
    updating local varible as data on the views has already been updated.
    However, if server returns error, the CRUD methods would immidiatly
    send the local variable (previous version) back to views with error
    message.
 
    * WHY *
 
    This database controller would reflect user-made changes immidiatly
    on the view and no need to wait for the confirmation from server
    but also it's able to display alert and recover to the original
    version when changes failed to be saved onto server.
    The reason why don't update data directly on the views is because
    the data is shared between views so each view should have its own
    dataUpdated obeserver for receiving updates from other views, and
    its own dataUpdated observer would be called anyway when the CRUD
    methods are invoked. Therefore, this method can avoid unecessary
    double update.
 
 */

import Foundation

class DatabaseController {
    
    let remote = Remote()
    
    var fridgeItemList: [NSDictionary]?
    var userProfile: NSDictionary?
    
    
    init() {
        // Observer for login status changed
        NotificationCenter.default.addObserver(self, selector: #selector(onLoginStatusChanged), name: .loginStatusChanged, object: nil)
    }
    
    
    @objc func onLoginStatusChanged () {
        // If user login, load/reload data
        guard UserDefaults.standard.dictionary(forKey: Key.userProfile) == nil else {
            self.getAllFridgeItems()
            return
        }
        // If user logout, remove all personal data
        self.userProfile = nil
        self.fridgeItemList = nil
    }
    
    
    // Notify controllers by loginStatusChanged observer
    func removeUser() {
        // Change login status
        UserDefaults.standard.removeObject(forKey: Key.userProfile)
        // Broadcast notification of successful logout
        NotificationCenter.default.post(name: .loginStatusChanged, object: self)
    }
    
    
    // Notify controllers by loginStatusChanged observer
    func getUser(method: String, id: String, token: String, name: String? = nil, email: String? = nil) {
        // Logout failed if user profile has not been removed
        let userProfile = UserDefaults.standard.dictionary(forKey: Key.userProfile) as NSDictionary?
        if userProfile != nil {return}
        self.remote.getUser(id: id) { userProfile, error in
            // If user exists in database
            if error == nil {
                self.userProfile = userProfile
                UserDefaults.standard.set(userProfile, forKey: Key.userProfile)
                NotificationCenter.default.post(name: .loginStatusChanged, object: self)
            // If user does not exist in database
            } else if error == "cannot find the user" {
                print("FH: user doesn't exist, start to add user...")
                self.remote.addUser(method: method, id: id, token: token, name: name, email: email) { userProfile, error in
                    if error == nil {
                        self.userProfile = userProfile
                        UserDefaults.standard.set(userProfile, forKey: Key.userProfile)
                        NotificationCenter.default.post(name: .loginStatusChanged, object: self)
                    } else {
                        print("FH: failed to add user...")
                        let userInfo = ["error_login" : error!]
                        NotificationCenter.default.post(name: .loginStatusChanged, object: self, userInfo: userInfo)
                    }
                }
            } else {
                print("FH: failed to find user...")
                let userInfo = ["error_login" : error!]
                NotificationCenter.default.post(name: .loginStatusChanged, object: self, userInfo: userInfo)
            }
        }
    }
    
    
    // Notify controllers by returning results to calling method (category popup window)
    // as category list is one of the properties of user profile which is dangerous
    // to update before received confirmation of server.
    func updateUser(id: String, categoryList: [NSDictionary]) {
        var categoryListString = ""
        for (i, item) in categoryList.enumerated() {
            // The "|" will not be placed after last element
            if i == categoryList.count - 1 {
               categoryListString += "{\"name\": \"\(item.object(forKey: "name")!)\", \"image\": \"\(item.object(forKey: "image")!)\"}"
            } else {
               categoryListString += "{\"name\": \"\(item.object(forKey: "name")!)\", \"image\": \"\(item.object(forKey: "image")!)\"} | "
            }
        }
        remote.updateUser(id: id, categoryList: categoryListString) { error in
            if error == nil {
                let userInfo = ["categoryList" : categoryList] as [AnyHashable : Any]
                NotificationCenter.default.post(name: .userUpdated, object: self, userInfo: userInfo)
            } else {
                let userInfo = ["error_updateUser" : error!] as [AnyHashable : Any]
                NotificationCenter.default.post(name: .userUpdated, object: self, userInfo: userInfo)
            }
        }
    }
    
    
    // Use the same method with updateUser on the server side
    func purchase(id: String, receipt: String? = nil, completion: @escaping (String?) -> Void) {
        remote.purchase(id: id, receipt: receipt) { userProfile, error in
            if error == nil {
                UserDefaults.standard.set(userProfile, forKey: Key.userProfile)
                completion(nil)
            } else {
                completion(error)
            }
        }
    }
    
    
    // Notify controllers by dataUpdated observer
    func getAllFridgeItems() {
        let userProfile = UserDefaults.standard.dictionary(forKey: Key.userProfile) as NSDictionary?
        if userProfile == nil {return}
        // Initial loading of fridge items
        // (generally happens at the loading of fridge list view)
        if self.fridgeItemList == nil {
            let uid = userProfile!.object(forKey: "id") as! String
            self.remote.getAllFridgeItems(uid: uid) { fridgeItems, error in
                if error == nil {
                    self.fridgeItemList = fridgeItems
                    // Notify views on data updated
                    let userInfo = ["fridgeItemList" : self.fridgeItemList!] as [AnyHashable : Any]
                    NotificationCenter.default.post(name: .dataUpdated, object: self, userInfo: userInfo)
                } else {
                    // Notify views on failed to update data
                    let userInfo = ["fridgeItemList" : self.fridgeItemList!, "error_fridgeItemList" : error!] as [AnyHashable : Any]
                    NotificationCenter.default.post(name: .dataUpdated, object: self, userInfo: userInfo)
                }
            }
        // If fridge list already loaded
        // (generally happens at loading of all other view controllers after
        // loading finished at fridge list view)
        } else {
            // Notify views on data updated
            let userInfo = ["fridgeItemList" : self.fridgeItemList!] as [AnyHashable : Any]
            NotificationCenter.default.post(name: .dataUpdated, object: self, userInfo: userInfo)
        }
    }
    
    
    // Notify controllers by returning results to calling method (fridge item
    // popup window) as new item needs ID which must be generated by database.
    func addFridgeItem(newFridgeItem: NSDictionary, completion: @escaping ([NSDictionary]?, String?) -> Void) {
        guard self.fridgeItemList != nil else {
            // Return error
            return
        }
        let userProfile = UserDefaults.standard.dictionary(forKey: Key.userProfile) as NSDictionary?
        if userProfile == nil { return }
        let uid = userProfile!.object(forKey: "id") as! String
        // Pass new fridge item to remote
        self.remote.addFridgeItem(uid: uid, newFridgeItem: newFridgeItem) { addedFridgeItem, error in
            if error == nil || addedFridgeItem != nil {
                self.fridgeItemList!.append(addedFridgeItem!)
                completion(self.fridgeItemList, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    
    func updateFridgeItem(fridgeItemId: String, dataToUpdate: [String : Any]) {
        guard self.fridgeItemList != nil else {
            // Return error
            return
        }
        var updatedFridgeItemList: [NSDictionary]? = []
        var updatedFridgeItem: NSMutableDictionary = NSMutableDictionary()
        for item in self.fridgeItemList! {
            if item.object(forKey: Key.fridgeItemId) as! String == fridgeItemId {
                updatedFridgeItem = NSMutableDictionary.init(dictionary: item)
                for (key, data) in dataToUpdate {
                    updatedFridgeItem[key] = data
                }
                // Empty date and need will be saved as "null" in server so the "null"
                // client receives would be transformed to NSNull locally which would not
                // be able to be parsed to date in server when it is sent back (updating),
                // therefore, if date keeps empty it should be converted to empty string
                // before sent back to server.
                if updatedFridgeItem["date"] as? NSNull != nil { updatedFridgeItem["date"] = "" }
                if updatedFridgeItem["need"] as? NSNull != nil { updatedFridgeItem["need"] = "" }
                updatedFridgeItemList!.append(NSDictionary.init(dictionary: updatedFridgeItem))
            } else {
                updatedFridgeItemList!.append(item)
            }
        }
        // Backup fridge item list before update and send the updated one
        // to views immediately
        let originalFridgeItemList = self.fridgeItemList
        self.fridgeItemList = updatedFridgeItemList
        let userInfo = ["fridgeItemList" : self.fridgeItemList!]
        NotificationCenter.default.post(name: .dataUpdated, object: self, userInfo: userInfo)
        // Pass updatedFridgeItem to remote
        // As user might update the data multiple times within a short period,
        // each time invoking remote updateFridgeItem method the fridge item list
        // will be backed up and sent to the remote method as param that will be
        // returned back in case update failed.
        self.remote.updateFridgeItem(originalFridgeItemList: originalFridgeItemList, updatedFridgeItem: updatedFridgeItem) {
            originalFridgeItemList, error in
            if error != nil {
                self.fridgeItemList = originalFridgeItemList
                let userInfo = ["fridgeItemList" : self.fridgeItemList!, "error_fridgeItemList" : error!] as [AnyHashable : Any]
                NotificationCenter.default.post(name: .dataUpdated, object: self, userInfo: userInfo)
            }
        }
    }
    
    
    // Notify controllers by dataUpdated observer (from fridge item section controller)
    func deleteFridgeItem(fridgeItemId: String) {
        let originalFridgeItemList = self.fridgeItemList
        guard fridgeItemList != nil else {
            return
        }
        for i in 0 ..< fridgeItemList!.count {
            if fridgeItemList![i].object(forKey: "_id") as? String == fridgeItemId {
                fridgeItemList?.remove(at: i)
                break
            }
        }
        let userInfo = ["fridgeItemList" : self.fridgeItemList!]
        NotificationCenter.default.post(name: .dataUpdated, object: self, userInfo: userInfo)
        // As user might delete multiple items within a short period,
        // each time invoking remote deleteFridgeItem method the fridge item list
        // will be backed up and sent to the remote method as param that will be
        // returned back in case update failed.
        remote.deleteFridgeItem(originalFridgeItemList: originalFridgeItemList, fridgeItemId: fridgeItemId) { originalFridgeItemList, error in
            if error != nil {
                self.fridgeItemList = originalFridgeItemList
                let userInfo = ["fridgeItemList" : self.fridgeItemList!, "error_fridgeItemList" : error!] as [AnyHashable : Any]
                NotificationCenter.default.post(name: .dataUpdated, object: self, userInfo: userInfo)
            }
        }
    }
    
    
    func getBarcodeName(barcode: String, completion: @escaping (String?, String?) -> Void) {
        print("FH: get barcode from database...")
        remote.getBarcode(barcode: barcode) { data, error in
            if error == nil {
                let name = data?.object(forKey: "name") as? String
                completion(name, nil)
            } else {
                print("FH: start to query barcode from Open Food Facts API...")
                self.remote.getBarcodeFromOpenFoodFacts(barcode: barcode) { data, error in
                    if error == nil && data != nil {
                        let product = data?.object(forKey: "product") as? NSDictionary
                        let name = product?.object(forKey: "product_name") as? String
                        print("FH: add found barcode to database...")
                        self.remote.addBarcode(name: name!, barcode: barcode) { error in }
                        completion(name, nil)
                    } else {
                        completion(nil, "Barcode not found")
                    }
                }
            }
        }
    }
    
    
    func addBarcode(barcode: String, name: String) {
        remote.addBarcode(name: name, barcode: barcode) { error in }
    }
}
