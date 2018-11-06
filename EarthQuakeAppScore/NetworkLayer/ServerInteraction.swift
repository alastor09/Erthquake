//
//  ServerInteraction.swift
//  EarthQuakeAppScore
//
//  Created by Soan Saini on 6/11/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import Foundation

enum Result<T>{
    case response(T)
    case error(error: Error)
}

// Protocol Declares Func required for a class to Fetch and Parse data
protocol ServerInteraction {
    associatedtype T
    // Provides the End Point URL which is used to fetch data
    var endPoint: String { get }
    // Checks if the Retrived data is valid and can be parsed
    func canParse(jsonData: [String : Any]) -> Bool
    // Parses the Actual data into Associated Type
    func parseFeed(jsonData: [String: Any]) -> [T]
    // Implementation of Actual fetching
    func fetchFeed( completionHandler: @escaping (Result<[T]>) -> Void)
}
