//
//  ViewController.swift
//  EarthQuakeAppScore
//
//  Created by Soan Saini on 6/11/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, ViewModelStatusDelegate {
    
    func viewModelUpdated() {
        refreshMap()
    }
    
    func viewModelFaulted(error: Error) {
        refreshMap()
    }

    @IBOutlet weak var mapView: MKMapView!
    private var viewModel : EarthQuakeListViewModel!

    public func setupViewModel(viewModel : EarthQuakeListViewModel) {
        self.viewModel = viewModel
        viewModel.setupDelegate(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshMap()
        
        if let focusedEarthQuake = viewModel.selectedEarthQuake {
            centerMapOnLocation(selectedViewModel: focusedEarthQuake)
        }
    }

    func refreshMap() -> Void {
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations({viewModel.earthQuakeModels.compactMap({MapArtwork(viewModel: $0)})}())
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(selectedViewModel: EarthQuakeViewModel) {
        let location = CLLocation(latitude:Double(truncating: selectedViewModel.latitude), longitude: Double(truncating: selectedViewModel.longitude))
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        do {
            try mapView.selectAnnotation(selectedArtwork(), animated: true)
        }
        catch SelectionError.invalidSelection {
            print("Error In Selection Occured")
        }
        catch {
             print("Unexpected error: \(error).")
        }
    }
    
    func selectedArtwork() throws -> MapArtwork {
        guard let selectedEarthQuake = viewModel.selectedEarthQuake else { throw SelectionError.invalidSelection }
        return mapView.annotations.compactMap({ $0 as? MapArtwork}).first(where: {$0.earthQuakeVieWModel == selectedEarthQuake})!
    }
}

extension ViewController: MKMapViewDelegate {
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? MapArtwork else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
        }
        return view
    }
}
