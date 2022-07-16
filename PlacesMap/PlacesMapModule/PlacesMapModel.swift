//
//  CafeMapModel.swift
//  CafeMap
//
//  Created by Artemiy Zuzin on 05.05.2022.
//

import Foundation
import CoreLocation
import Combine
import MapKit
import SwiftUI

final class PlacesMapModel: ObservableObject {
    
    private let dataManager: DataManager
    @ObservedObject private var locationManager: LocationManager
    
    init(dataManager: DataManager, locationManager: LocationManager) {
        self.dataManager = dataManager
        self.locationManager = locationManager
        
        self.locationManager.$coodinateRegion
            .assign(to: \.coordinateRegion, on: self)
            .store(in: &self.subscriptions)
        
        self.dataManager.$allPlaces
            .assign(to: \.places, on: self)
            .store(in: &self.subscriptions)
    }
    
    @Published var coordinateRegion = MKCoordinateRegion()
    @Published var places = [Place]()
    
    var anotations: [MKAnnotation] {
        var anotations = [MKAnnotation]()
        
        self.places.forEach { place in
            let anotation = MKPointAnnotation()
            
            anotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(place.lat),
                                                          longitude: CLLocationDegrees(place.lon))
            
            anotations.append(anotation)
        }
                
        return anotations
    }
        
    private var subscriptions: Set<AnyCancellable> = []
    
    func getAllPlaces() {
        self.dataManager.getAllPlaces()
    }
    
    func getUserLocation() {
        self.locationManager.getUserLocation()
    }
    
}
