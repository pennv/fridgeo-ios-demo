//
//  Barcode.swift
//  Fridge Helper
//
//  Created by Penn on 14/6/20.
//  Copyright © 2020 Penn. All rights reserved.
//

import UIKit
import Alamofire

extension Remote {
    
    func addBarcode(name: String, barcode: String, completion: @escaping (String?) -> Void) {
        let parameters: [String: String] = [
            "auth": self.auth,
            "name": name,
            "barcode" : barcode
        ]
        AF.request(url + "/barcode/add", method: .post, parameters: parameters).responseJSON { response in
            let statusCode = response.response!.statusCode
            if statusCode == 200 {
                let data = response.value as? NSDictionary
                print("FH: succeeded to add barcode \(String(describing: data?["barcode"]!)) to database...")
                completion(nil)
            } else {
                let data = response.value as? NSDictionary
                let error = data!.object(forKey: "error")!
                print("FH: (server) \(error)...")
                completion(error as? String)
            }
        }
    }
    
    
    func getBarcode(barcode: String, completion: @escaping (NSDictionary?, String?) -> Void) {
        let parameters: [String: String] = [
            "auth": self.auth,
            "barcode": barcode
        ]
        AF.request(url + "/barcode/get", method: .post, parameters: parameters).responseJSON { response in
            let statusCode = response.response!.statusCode
            switch statusCode {
            case 200:
                let data = response.value as? NSDictionary
                print("FH: succeeded to get barcode...")
                completion(data, nil)
            case 404:
                print("FH: barcode not found...")
                completion(nil, "Barcode not found")
            default:
                let data = response.value as? NSDictionary
                let error = data!.object(forKey: "error")!
                print("FH: (server) \(error)...")
                completion(nil, error as? String)
            }
        }
    }
    
    
    func getBarcodeFromOpenFoodFacts(barcode: String, completion: @escaping (NSDictionary?, String?) -> Void) {
        let requestURL = "https://world.openfoodfacts.org/api/v0/product/" + barcode + ".json"
        AF.request(requestURL).responseJSON { response in
            let data = response.value as? NSDictionary
            let status = data?.object(forKey: "status") as? Int
            if status == 1 {
                print("FH: succeeded to get barcode from open food facts...")
                completion(data, nil)
            } else {
                print("FH: failed to get barcode from Open Food Facts API...")
                completion(nil, "Barcode not found from open food facts")
            }
        }
    }
}
