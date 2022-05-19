//
//  LocationManager.swift
//  CafeMap
//
//  Created by Artemiy Zuzin on 06.05.2022.
//

import Foundation
import CoreLocation
import MapKit

final class LocationManager: NSObject, ObservableObject {
    
    override private init() {
        super.init()
        
        self.manager.delegate = self
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
    }
        
    static let shared = LocationManager()
    
    @Published var coodinateRegion = MKCoordinateRegion()
    
    private let manager = CLLocationManager()
    
    func getUserLocation() {
        self.manager.requestWhenInUseAuthorization()
        self.manager.startUpdatingLocation()
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        self.coodinateRegion = MKCoordinateRegion(MKMapRect(origin: MKMapPoint(location.coordinate), size: MKMapSize(width: 0.8, height: 0.8)))
    }
}
