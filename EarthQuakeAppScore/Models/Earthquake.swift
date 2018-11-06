//
//  Earthquake.swift
//  EarthQuakeAppScore
//
//  Created by Soan Saini on 6/11/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import Foundation

struct Earthquake : Equatable
{
    let id: String
    let place: String
    let time: Date
    private let coordinate : [NSNumber]
    let magnitude: NSNumber
    
    var longitude : NSNumber {
        return coordinate[0]
    }
    
    var latitude : NSNumber {
        return coordinate[1]
    }
    
    var depth : NSNumber {
        return coordinate[2]
    }
    
    init(jsonDict: [String: Any]) {
        let propertiesData = (jsonDict["properties"] as? [String: Any])!
        let geometryData = (jsonDict["geometry"] as? [String: Any])!

        self.id = (jsonDict["id"] as? String)!
        self.place = (propertiesData["place"] as? String)!
        self.time = Date(timeIntervalSince1970: TimeInterval((propertiesData["time"] as? Int)!))
        self.magnitude = (propertiesData["mag"] as? NSNumber)!
        self.coordinate = ((geometryData["coordinates"] as? [NSNumber])!)
    }
    
    static func == (lhs: Earthquake, rhs: Earthquake) -> Bool {
        return lhs.id == rhs.id
    }
}
