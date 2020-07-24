//
//  Local.swift
//  Fridge Helper
//
//  Created by Penn on 30/3/20.
//  Copyright © 2020 Penn. All rights reserved.
//

//import UIKit
//import PINCache
//
//class Local {
//
//    func saveUserProfile(data: NSDictionary) {
//        PINCache.shared().setObject(data, forKey: Key.userProfile)
//        print("FH: succeeded to cache user profile...")
//    }
//    func getUserProfile(completion: @escaping (NSDictionary?, String?) -> Void) {
//        PINCache.shared().object(forKey: Key.userProfile) { (cache, key, object) in
//            if let data = object as? NSDictionary {
//                completion(data, nil)
//            } else {
//                completion(nil, "Unkown error")
//            }
//        }
//    }
//
//
//    func saveFridgeItems(data: [NSDictionary]) {
//        PINCache.shared().setObject(data as NSArray, forKey: Key.fridgeItems)
//        print("FH: succeeded to cache fridge items...")
//    }
//    func getFridgeItems(completion: @escaping ([NSDictionary]?, String?) -> Void) {
//        PINCache.shared().object(forKey: Key.fridgeItems) { (cache, key, object) in
//            if let data = object as? [NSDictionary] {
//                completion(data, nil)
//            } else {
//                completion(nil, "Unkown error")
//            }
//        }
//    }
//
//
//
//    func removeFromCache(key: String) {
//        PINCache.shared().removeObject(forKey: Key.userProfile)
//    }
//}
