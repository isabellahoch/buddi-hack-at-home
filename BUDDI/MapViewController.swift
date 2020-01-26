//
//  MapViewController.swift
//
//
//  Created by Isabella Hochschild on 1/26/20.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
//    var previousVC = ViewController()
//    var selectedLocation = "3165 Kifer Rd, Santa Clara, CA 95051"
    
    @IBOutlet weak var mapView: MKMapView!
    
      let locationManager = CLLocationManager()
       
      override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
    }

}
