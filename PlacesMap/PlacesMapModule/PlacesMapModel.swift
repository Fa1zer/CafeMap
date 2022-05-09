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

final class PlacesMapModel: ObservableObject {
    
    init() {
        self.locationManager.$coodinateRegion
            .assign(to: \.coordinateRegion, on: self)
            .store(in: &subscriptions)
    }
    
    @Published var coordinateRegion = MKCoordinateRegion()
    
    private var subscriptions: Set<AnyCancellable> = []
    private let locationManager = LocationManager.shared
    
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
