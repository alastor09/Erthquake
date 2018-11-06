//
//  ProdServerInteraction.swift
//  EarthQuakeAppScore
//
//  Created by Soan Saini on 6/11/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import Foundation
import Alamofire

// Default Implementation for fetch Feed
extension ServerInteraction {
    public func fetchFeed( completionHandler: @escaping (Result<[T]>) -> Void) {
        Alamofire.request(endPoint).responseString(completionHandler: { (responseData) in
            
            if let error = responseData.result.error {
                completionHandler(Result.error(error: error))
                return
            }
            
            if let data = responseData.result.value?.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                var jsonResult:Any
                do {
                    jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                }
                catch {
                    print("Error : \(error.localizedDescription)")
                    completionHandler(Result.error(error: NSError(domain:"JSON Not Proper", code:1101, userInfo:nil)))
                    return
                }
                
                guard let jsonData = jsonResult as? [String: Any] else {
                    completionHandler(Result.error(error: NSError(domain:"JSON Not Proper", code:1101, userInfo:nil)))
                    return
                }
                if !self.canParse(jsonData: jsonData) {
                    completionHandler(Result.error(error: NSError(domain:"Json not in Right Format", code:1103, userInfo:nil)))
                    return
                }
                
                let feedReceived = self.parseFeed(jsonData: jsonData)
                completionHandler(Result.response(feedReceived))
                
            }
        })
    }
}
