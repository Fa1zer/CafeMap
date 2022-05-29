//
//  AddPlaceViewModel.swift
//  PlacesMap
//
//  Created by Artemiy Zuzin on 23.05.2022.
//

import Foundation
import CoreLocation
import Combine
import MapKit
import SwiftUI

final class AddPlaceViewModel: ObservableObject, Coordinatable {
    
    @ObservedObject private var model: AddPlaceModel
    
    init(model: AddPlaceModel) {
        self.model = model
        
        self.model.$coordinateRegion
            .assign(to: \.coordinateRegion, on: self)
            .store(in: &self.subribtions)
    }
    
    var coordinator: NavigationCoordinator?
    @Published var coordinateRegion = MKCoordinateRegion()
    @Published var place = Place(id: UUID(), name: "", street: "", placeDescription: "", lat: 0, lon: 0, userID: UUID())
    
    private var subribtions: Set<AnyCancellable> = []
    
    func getUserLocation() {
        self.model.getUserLocation()
    }
    
    func saveChanges() {
        self.model.saveChanges(place: self.place)
    }
    
    func goToPlacesMap() -> PlacesMapView {
        return self.coordinator?.goToPlacesMap() ?? PlacesMapView(viewModel: PlacesMapViewModel(model: PlacesMapModel(dataManager: DataManager(), locationManager: LocationManager.shared)))
    }
    
}
