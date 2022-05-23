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
import Firebase
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
        
        self.getAllPlaces()
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
            .receive(on: RunLoop.main)
            .assign(to: \.places, on: self)
            .store(in: &self.subscriptions)
    }
    
    func getUserLocation() {
        self.locationManager.getUserLocation()
    }
    
    func signOut() -> Bool {
        if let _ = Firebase.Auth.auth().currentUser {
            do {
                try Firebase.Auth.auth().signOut()
                
                return true
            } catch {
                print("❌ Error: \(error)")
            }
        }
        
        return false
    }
    
}
