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
    }
    
    @Published var coordinateRegion = MKCoordinateRegion()
    
    var coordinator: NavigationCoordinator?
    private let model = PlacesMapModel()
    private var subribtions: Set<AnyCancellable> = []
    
    func getUserLocation() {
        self.model.getUserLocation()
    }
    
    func goToRegistration() -> RegistrationView {
        return self.coordinator?.goToRegistration() ?? RegistrationView(viewModel: RegistrationViewModel())
    }
    
}
