//
//  FridgeItem.swift
//  Fridge Helper
//
//  Created by Penn on 10/4/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit
import Alamofire

extension Remote {

    func getAllFridgeItems(uid: String, completion: @escaping ([NSDictionary]?, String?) -> Void) {
        let parameters: [String: String] = [
            "auth": self.auth,
            "uid": uid,
        ]
        AF.request(url + "/fridge-item/get-all", method: .post, parameters: parameters).responseJSON { response in
            let statusCode = response.response!.statusCode
            switch statusCode {
            case 200:
                let data = response.value as? NSArray
                var fridgeItems:[NSDictionary] = []
                for item in data! {
                    fridgeItems.append(item as! NSDictionary)
                }
                print("FH: succeeded to get all fridge items of user...")
                completion(fridgeItems, nil)
            case 404:
                print("FH: user has not added any items...")
                completion([], nil)
            case 400:
                let data = response.value as? NSDictionary
                let error = data!.object(forKey: "error")!
                print("FH: (server) \(error)...")
                completion(nil, error as? String)
            default:
                print("FH: unknown error !!!...")
                completion(nil, "Unknow error")
            }
        }
    }
    
    
    func addFridgeItem(uid: String, newFridgeItem: NSDictionary, completion: @escaping (NSDictionary?, String?) -> Void) {
        var parameters = NSMutableDictionary.init(dictionary: newFridgeItem) as! [String : Any]
        parameters["auth"] = self.auth
        parameters["uid"] = uid
        AF.request(url + "/fridge-item/add", method: .post, parameters: parameters).responseJSON { response in
            let statusCode = response.response!.statusCode
            if statusCode == 200 {
                let data = response.value as? NSDictionary
                print("FH: succeeded to add item \(String(describing: data?["_id"]!))...")
                completion(data, nil)
            } else {
                let data = response.value as? NSDictionary
                let error = data!.object(forKey: "error")!
                print("FH: (server) \(error)...")
                completion(nil, error as? String)
            }
        }
    }
    
    
    func updateFridgeItem(originalFridgeItemList: [NSDictionary]?, updatedFridgeItem: NSMutableDictionary, completion: @escaping ([NSDictionary]?, String?) -> Void) {
        var parameters: [String : Any] = [:]
        parameters["auth"] = self.auth
        for (key, value) in updatedFridgeItem {
            parameters[key as! String] = value
        }
        AF.request(url + "/fridge-item/update", method: .post, parameters: parameters).responseJSON { response in
            let statusCode = response.response!.statusCode
            if statusCode == 200 {
                print("FH: succeeded to update item \(String(describing: updatedFridgeItem["_id"]!))...")
                completion(nil, nil)
            } else {
                let data = response.value as? NSDictionary
                let error = data!.object(forKey: "error")!
                print("FH: (server) \(error)...")
                completion(originalFridgeItemList, error as? String)
            }
        }
    }
    
    
    func deleteFridgeItem(originalFridgeItemList: [NSDictionary]?, fridgeItemId: String, completion: @escaping ([NSDictionary]?, String?) -> Void) {
        let parameters: [String: String] = [
            "auth": self.auth,
            "_id": fridgeItemId
        ]
        AF.request(url + "/fridge-item/delete", method: .post, parameters: parameters).responseJSON { response in
            let statusCode = response.response!.statusCode
            if statusCode == 200 {
                print("FH: succeeded to delete item \(fridgeItemId)...")
                completion(nil, nil)
            } else {
                let data = response.value as? NSDictionary
                let error = data!.object(forKey: "error")!
                print("FH: (server) \(error)...")
                completion(originalFridgeItemList, error as? String)
            }
        }
    }
}
