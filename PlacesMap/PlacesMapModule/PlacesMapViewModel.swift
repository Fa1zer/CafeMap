//
//  CafeMapViewModel.swift
//  CafeMap
//
//  Created by Artemiy Zuzin on 05.05.2022.
//

import Foundation
import CoreLocation
import MapKit
import SwiftUI
import Combine

final class PlacesMapViewModel: ObservableObject, Coordinatable {
    
    @ObservedObject private var model: PlacesMapModel
    
    init(model: PlacesMapModel) {
        self.model = model
        
        self.model.$coordinateRegion
            .assign(to: \.coordinateRegion, on: self)
            .store(in: &self.subribtions)
        
        self.model.$places
            .assign(to: \.places, on: self)
            .store(in: &self.subribtions)
    }
    
    @Published var coordinateRegion = MKCoordinateRegion()
    @Published var places = [Place]()
    @Published var image = UIImage(named: "logo") ?? UIImage()
    @Published var name = ""
    @Published var street = ""
    
    var currentPlace = Place(id: UUID(), name: "", street: "", placeDescription: "", lat: 0, lon: 0, userID: UUID())
    var anotations: [MKAnnotation] { return self.model.anotations }
    var coordinator: NavigationCoordinator?
    private var subribtions: Set<AnyCancellable> = []
    
    func getUserLocation() {
        self.model.getUserLocation()
    }
    
    func getAllPlaces() {
        self.model.getAllPlaces()
    }
    
    func goToPlaceInformation(place: Place) -> PlaceInformationView {
        return self.coordinator?.goToPlaceInformation(place: place) ?? PlaceInformationView(viewModel: PlaceInformationViewModel(model: PlaceInformationModel(place: place)))
    }
    
    func goToRegistration() -> RegistrationView {
        return self.coordinator?.goToRegistration() ?? RegistrationView(viewModel: RegistrationViewModel(model: RegistrationModel(dataManager: DataManager())))
    }
    
    func goToMyPlaces() -> MyPlacesView {
        return self.coordinator?.goToMyPlaces() ?? MyPlacesView(viewModel: MyPlacesViewModel(model: MyPlacesModel(dataManager: DataManager())))
    }
    
//    func signOut() -> Bool {
//        return self.model.signOut()
//    }
    
}
