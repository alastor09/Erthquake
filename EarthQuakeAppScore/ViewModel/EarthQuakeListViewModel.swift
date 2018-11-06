//
//  EarthQuakeListViewModel.swift
//  EarthQuakeAppScore
//
//  Created by Soan Saini on 7/11/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import Foundation

class EarthQuakeListViewModel {
    private var fetchedEarthQuakes : [Earthquake] = Array.init()
    private let serverClient: EarthquakeApiClient = EarthquakeApiClient()
    private var delegate: ViewModelStatusDelegate!
    
    internal var earthQuakeModels : [EarthQuakeViewModel] {
        return fetchedEarthQuakes.compactMap({EarthQuakeViewModel(earthQuake: $0)})
    }
    
    public var selectedEarthQuake : EarthQuakeViewModel?
    
    public var totalEarthQuakes : Int {
        return fetchedEarthQuakes.count
    }
    
    public func setupDelegate(delegate : ViewModelStatusDelegate) {
        self.delegate = delegate
    }
    
    public func refreshEarthQuakes() -> Void {
        serverClient.fetchFeed { (result) in
            switch result{
            case .response(let data):
                self.fetchedEarthQuakes = data
                self.selectedEarthQuake = nil
                self.delegate.viewModelUpdated()
                break
            case .error(error: let error):
                self.selectedEarthQuake = nil
                self.fetchedEarthQuakes.removeAll()
                self.delegate.viewModelFaulted(error: error)
                break
            }
        }
    }
    
    public func earthQuakeAtIndex(index: Int) -> EarthQuakeViewModel {
        return earthQuakeModels[index]
    }
    
    public func selectEarthQuake(index: Int) -> Void {
        selectedEarthQuake = earthQuakeAtIndex(index: index)
    }
    
    public func deSelectEarthQuake() -> Void {
        selectedEarthQuake = nil
    }
}
