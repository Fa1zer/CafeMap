//
//  NavigationCoordinator.swift
//  CafeMap
//
//  Created by Artemiy Zuzin on 06.05.2022.
//

import Foundation

protocol Coordinatable {
    var coordinator: NavigationCoordinator? { get set }
}

final class NavigationCoordinator {
    
    func start() -> RegistrationView {
        return self.goToRegistration()
    }
    
    func goToCafeMap() -> PlacesMapView {
        let viewModel = PlacesMapViewModel()
        let view = PlacesMapView(viewModel: viewModel)
                
        viewModel.coordinator = self
        
        return view
    }
    
    func goToRegistration() -> RegistrationView {
        let viewModel = RegistrationViewModel()
        let view = RegistrationView(viewModel: viewModel)
        
        viewModel.coordinator = self
        
        return view
    }
    
    func goToPlaceInformation() -> PlaceInformationView {
        let viewModel = PlaceInformationViewModel()
        let view = PlaceInformationView(viewModel: viewModel)
        
        viewModel.coordinator = self
        
        return view
    }
    
    func goToRedactPlace() -> RedactPlaceView {
        let viewModel = RedactPlaceViewModel()
        let view = RedactPlaceView(viewModel: viewModel)
        
        viewModel.coordinator = self
        
        return view
    }
    
    func goToMyPlaces() -> MyPlacesView {
        let viewModel = MyPlacesViewModel()
        let view = MyPlacesView(viewModel: viewModel)
        
        viewModel.coordinator = self
        
        return view
    }
    
}
