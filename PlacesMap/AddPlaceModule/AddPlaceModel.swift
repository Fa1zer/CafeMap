//
//  AddPlaceModel.swift
//  PlacesMap
//
//  Created by Artemiy Zuzin on 23.05.2022.
//

import Foundation
import Combine
import SwiftUI
import CoreLocation
import MapKit

final class AddPlaceModel: ObservableObject {
    
    private let dataManager: DataManager
    @ObservedObject private var locationManager: LocationManager
    
    init(dataManager: DataManager, locationManager: LocationManager) {
        self.dataManager = dataManager
        self.locationManager = locationManager
        
        self.locationManager.$coodinateRegion
            .assign(to: \.coordinateRegion, on: self)
            .store(in: &self.subscriptions)
    }
    
    @Published var coordinateRegion = MKCoordinateRegion()
    @Published var name = ""
    @Published var street = ""
    @Published var description = ""
    @Published var imageName = ""
    @Published var lat: Float = 0
    @Published var lon: Float = 0
    
    private var subscriptions: Set<AnyCancellable> = []
    
    func getUserLocation() {
        self.locationManager.getUserLocation()
    }
    
    func saveChanges() {
        print(#function)
    }
    
    func deletePlace() {
        print(#function)
    }
    
}