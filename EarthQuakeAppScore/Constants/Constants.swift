//
//  Constants.swift
//  EarthQuakeAppScore
//
//  Created by Soan Saini on 6/11/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import Foundation

// Constants for the Application
struct APPURL {
    // All the possible Domains
    private struct Domains {
        static let Prod = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary"
    }
    
    private static let domain = Domains.Prod
    
    // All the URls used inside Application
    private static let earthQuakeEndPoint = "/all_day.geojson"
    
    static let earthQuakeURL = Domains.Prod + earthQuakeEndPoint
}
