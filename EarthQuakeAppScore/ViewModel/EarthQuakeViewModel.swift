//
//  EarthQuakeViewModel.swift
//  EarthQuakeAppScore
//
//  Created by Soan Saini on 6/11/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import Foundation

protocol ViewModelStatusDelegate {
    func viewModelUpdated()
    func viewModelFaulted(error: Error)
}

struct EarthQuakeViewModel: Equatable {
    
    public var displayText: String{
        return earthQuake.place
    }
    
    public var subtitleText: String{
        return earthQuake.time.description
    }
    
    public var longitude: NSNumber{
        return earthQuake.longitude
    }
    
    public var latitude: NSNumber{
        return earthQuake.latitude
    }
    
    private let earthQuake : Earthquake
    
    init(earthQuake : Earthquake) {
        self.earthQuake = earthQuake
    }
    
    static func == (lhs: EarthQuakeViewModel, rhs: EarthQuakeViewModel) -> Bool {
        return lhs.earthQuake == rhs.earthQuake
    }
}
