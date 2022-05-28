//
//  MyPlacesViewModel.swift
//  PlacesMap
//
//  Created by Artemiy Zuzin on 09.05.2022.
//

import Foundation

final class MyPlacesViewModel: ObservableObject, Coordinatable {
    
    private let model: MyPlacesModel
    
    init(model: MyPlacesModel) {
        self.model = model
        
        self.model.$places
            .assign(to: &self.$places)
    }
    
    @Published var places = [Place]()
    
    var coordinator: NavigationCoordinator?
        
    func goToRedactPlace(place: Place) -> RedactPlaceView {
        return self.coordinator?.goToRedactPlace(place: place) ?? RedactPlaceView(viewModel: RedactPlaceViewModel(model: RedactPlaceModel(dataManager: DataManager(), place: place)))
    }
    
    func goToAddPlace() -> AddPlaceView {
        return self.coordinator?.goToAddPlace() ?? AddPlaceView(viewModel: AddPlaceViewModel(model: AddPlaceModel(dataManager: DataManager(), locationManager: LocationManager.shared)))
    }
    
    func goToPlacesMap() -> PlacesMapView {
        return self.coordinator?.goToPlacesMap() ?? PlacesMapView(viewModel: PlacesMapViewModel(model: PlacesMapModel(dataManager: DataManager(), locationManager: LocationManager.shared)))
    }
    
    func getAllPlaces() {
        self.model.getAllPlaces()
    }
    
}
