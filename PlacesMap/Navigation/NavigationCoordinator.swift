//
//  NavigationCoordinator.swift
//  CafeMap
//
//  Created by Artemiy Zuzin on 06.05.2022.
//

import Foundation
import SwiftUI

protocol Coordinatable {
    var coordinator: NavigationCoordinator? { get set }
}

final class NavigationCoordinator {
    
    init() {
        if let(email, password) = self.keychainManager.getEmailAndPassword() {
            self.dataManager.authUser(user: User(email: email, password: password), didComplete: { }, didNotComplete: { _ in })
        }
    }
    
    private let dataManager = DataManager()
    private let locationManager = LocationManager.shared
    private let keychainManager = KeychainManager()
    
    func start() -> some View {
        guard self.dataManager.userID != nil else {
            let viewModel = RegistrationViewModel(model: RegistrationModel(dataManager: self.dataManager, keychainManager: self.keychainManager))
            let view = RegistrationView(viewModel: viewModel)
            
            viewModel.coordinator = self
            
            return AnyView(view)
        }
        
        return AnyView(self.goToPlacesMap())
    }
    
    func goToPlacesMap() -> PlacesMapView {
        let viewModel = PlacesMapViewModel(model: PlacesMapModel(dataManager: self.dataManager, locationManager: self.locationManager))
        let view = PlacesMapView(viewModel: viewModel)
                
        viewModel.coordinator = self
        
        return view
    }
    
    func goToRegistration() -> RegistrationView {
        let viewModel = RegistrationViewModel(model: RegistrationModel(dataManager: self.dataManager))
        let view = RegistrationView(viewModel: viewModel)
        
        viewModel.coordinator = self
        
        return view
    }
    
    func goToPlaceInformation(place: Place) -> PlaceInformationView {
        let viewModel = PlaceInformationViewModel(model: PlaceInformationModel(place: place))
        let view = PlaceInformationView(viewModel: viewModel)
        
        viewModel.coordinator = self
        
        return view
    }
    
    func goToRedactPlace(place: Place) -> RedactPlaceView {
        let viewModel = RedactPlaceViewModel(model: RedactPlaceModel(dataManager: self.dataManager, place: place))
        let view = RedactPlaceView(viewModel: viewModel)
        
        viewModel.coordinator = self
        
        return view
    }
    
    func goToMyPlaces() -> MyPlacesView {
        let viewModel = MyPlacesViewModel(model: MyPlacesModel(dataManager: self.dataManager))
        let view = MyPlacesView(viewModel: viewModel)
        
        viewModel.coordinator = self
        
        return view
    }
    
    func goToAddPlace() -> AddPlaceView {
        let viewModel = AddPlaceViewModel(model: AddPlaceModel(dataManager: self.dataManager, locationManager: self.locationManager))
        let view = AddPlaceView(viewModel: viewModel)
        
        viewModel.coordinator = self
        
        return view
    }
    
}
