//
//  User.swift
//  Fridge Helper
//
//  Created by Penn on 30/3/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit
import Alamofire

extension Remote {
    
    
    func getUser(id: String, completion: @escaping (NSDictionary?, String?) -> Void) {
        let parameters: [String: String] = [
            "auth": self.auth,
            "id": id,
        ]
        AF.request(url + "/user/get", method: .post, parameters: parameters).responseJSON { response in
            let statusCode = response.response!.statusCode
            let data = response.value as? NSDictionary
            switch statusCode {
            case 200:
                print("FH: succeeded to get user profile...")
                completion(data!, nil)
            case 404:
                print("FH: (server) \(data!.object(forKey: "error")!)...")
                completion(nil, data!.object(forKey: "error")! as? String)
            default:
                print("FH: unknown error !!!...")
                completion(nil, "Unknow error")
            }
        }
    }
    
    
    func addUser(method: String, id: String, token: String, name: String? = nil, email: String? = nil, completion: @escaping (NSDictionary?, String?) -> Void) {
        var parameters: [String: String] = [
            "auth": self.auth,
            "method": method,
            "id": id,
            "token": token
        ]
        if method == "apple" {
            parameters = [
                "auth": self.auth,
                "method": method,
                "id": id,
                "name": name ?? "Apple User",
                "email": email ?? ""
            ]
        }
        AF.request(url + "/user/add", method: .post, parameters: parameters).responseJSON { response in
            let statusCode = response.response!.statusCode
            let data = response.value as? NSDictionary
            switch statusCode {
            case 200:
                print("FH: succeeded to add user on database...")
                completion(data!, nil)
            case 403:
                print("FH: (server) \(data!.object(forKey: "error")!)...")
                completion(nil, data!.object(forKey: "error")! as? String)
            default:
                print("FH: unknown error...")
                completion(nil, "Unknow error")
            }
        }
    }
    
    
    func updateUser(id: String, categoryList: String, completion: @escaping (String?) -> Void) {
        let parameters: [String : Any] = [
            "auth": self.auth,
            "id": id,
            "category": categoryList
        ]
        AF.request(url + "/user/update", method: .post, parameters: parameters).responseJSON { response in
            let statusCode = response.response!.statusCode
            if statusCode == 200 {
                print("FH: succeeded to update user-defined category...")
                completion(nil)
            } else {
                let data = response.value as? NSDictionary
                let error = data!.object(forKey: "error")!
                print("FH: (server) \(error)...")
                completion(error as? String)
            }
        }
    }
    
    
    func purchase(id: String, receipt: String? = nil, completion: @escaping (NSDictionary?, String?) -> Void) {
        // The expire date of purchase will remain the same when user
        // purchase expired
        let parameters: [String : Any] = [
            "auth": self.auth,
            "id": id,
            "receipt": receipt ?? "",
        ]
        AF.request(url + "/user/update", method: .post, parameters: parameters).responseJSON { response in
            let statusCode = response.response!.statusCode
            let data = response.value as? NSDictionary
            if statusCode == 200 {
                print("FH: succeeded to update user purchase info...")
                completion(data, nil)
            } else {
                let data = response.value as? NSDictionary
                let error = data!.object(forKey: "error")!
                print("FH: (server) \(error)...")
                completion(nil, error as? String)
            }
        }
    }}



