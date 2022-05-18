//
//  CafeMapViewModel.swift
//  CafeMap
//
//  Created by Artemiy Zuzin on 05.05.2022.
//

import Foundation
import CoreLocation
import MapKit
import Combine

final class PlacesMapViewModel: ObservableObject, Coordinatable {
    
    init() {
        self.model.$coordinateRegion
            .assign(to: \.coordinateRegion, on: self)
            .store(in: &self.subribtions)
        self.model.$anotations
            .assign(to: \.anotations, on: self)
            .store(in: &self.subribtions)
    }
    
    @Published var coordinateRegion = MKCoordinateRegion()
    @Published var anotations = [MKAnnotation]()
    
    var coordinator: NavigationCoordinator?
    private let model = PlacesMapModel()
    private var subribtions: Set<AnyCancellable> = []
    
    func getUserLocation() {
        self.model.getUserLocation()
    }
    
    func goToPlaceInformation() -> PlaceInformationView {
        return self.coordinator?.goToPlaceInformation() ?? PlaceInformationView(viewModel: PlaceInformationViewModel())
    }
    
    func goToRegistration() -> RegistrationView {
        return self.coordinator?.goToRegistration() ?? RegistrationView(viewModel: RegistrationViewModel())
    }
    
    func goToMyPlaces() -> MyPlacesView {
        return self.coordinator?.goToMyPlaces() ?? MyPlacesView(viewModel: MyPlacesViewModel())
    }
    
    func signOut() -> Bool {
        return self.model.signOut()
    }
    
}
