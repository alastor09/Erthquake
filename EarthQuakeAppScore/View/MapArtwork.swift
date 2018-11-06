//
//  MapArtwork.swift
//  EarthQuakeAppScore
//
//  Created by Soan Saini on 7/11/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import Foundation
import MapKit

class MapArtwork: NSObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D {
        return (CLLocation.init(latitude: Double(truncating: earthQuakeVieWModel.latitude), longitude: Double(truncating: earthQuakeVieWModel.longitude))).coordinate
    }
    
    let earthQuakeVieWModel : EarthQuakeViewModel
    
    init(viewModel : EarthQuakeViewModel) {
        self.earthQuakeVieWModel = viewModel
        super.init()
    }
    
    var title: String?{
        return earthQuakeVieWModel.displayText
    }
    
    var subtitle: String? {
        return earthQuakeVieWModel.subtitleText
    }
}
