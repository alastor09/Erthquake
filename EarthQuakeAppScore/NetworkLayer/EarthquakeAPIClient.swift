//
//  EarthquakeAPIClient.swift
//  EarthQuakeAppScore
//
//  Created by Soan Saini on 6/11/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import Foundation

class EarthquakeApiClient: ServerInteraction {
    
    internal let endPoint: String = APPURL.earthQuakeURL
    
    internal func canParse(jsonData: [String : Any]) -> Bool {
        return jsonData["features"] is [[String : Any]]
    }
    
    internal func parseFeed(jsonData: [String : Any]) -> [Earthquake] {
        var dataArray: [Earthquake] = []
        for data in jsonData["features"] as! [[String : Any]] {
                dataArray.append(Earthquake(jsonDict: data))
        }
        return dataArray
    }
    
    internal typealias T = Earthquake
}
