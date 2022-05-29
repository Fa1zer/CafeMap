//
//  RedactPlaceViewModel.swift
//  PlacesMap
//
//  Created by Artemiy Zuzin on 09.05.2022.
//

import Foundation
import SwiftUI
import Combine

final class RedactPlaceViewModel: ObservableObject, Coordinatable {
    
    private let model: RedactPlaceModel
    
    init(model: RedactPlaceModel) {
        self.model = model
        
        self.model.$place
            .assign(to: &self.$place)
    }
    
    var coordinator: NavigationCoordinator?
    
    @Published var place = Place(id: UUID(), name: "", street: "", placeDescription: "", lat: 0, lon: 0, userID: UUID())
    
    private var subribtions = Set<AnyCancellable>()
        
    func saveChanges() {
        self.model.saveChanges(place: self.place)
    }
    
    func deletePlace() {
        self.model.deletePlace()
    }
    
    func goToPlacesMap() -> PlacesMapView {
        return self.coordinator?.goToPlacesMap() ?? PlacesMapView(viewModel: PlacesMapViewModel(model: PlacesMapModel(dataManager: DataManager(), locationManager: LocationManager.shared)))
    }
    
}
