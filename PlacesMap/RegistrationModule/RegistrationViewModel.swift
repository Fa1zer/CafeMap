//
//  LogInViewModel.swift
//  CafeMap
//
//  Created by Artemiy Zuzin on 04.05.2022.
//

import Foundation
import Combine

final class RegistrationViewModel: ObservableObject, Coordinatable {
    
    private let model: RegistrationModel
        
        init(model: RegistrationModel) {
            self.model = model
        }
    
    var coordinator: NavigationCoordinator?
    
    @Published var password = ""
    @Published var email = ""
        
    func logIn(didComplete: @escaping () -> Void, didNotComplete: @escaping (LogInErrors) -> Void) {
        if password.count < 6 {
            didNotComplete(.passwordFieldIsSmall)
            
            return
        }
        
        self.model.logIn(
            email: self.email,
            passsword: self.password,
            didComplete: didComplete,
            didNotComplete: didNotComplete
        )
    }
    
    func signIn(didComplete: @escaping () -> Void, didNotComplete: @escaping (SignInErrors) -> Void) {
        if password.count < 6 {
            didNotComplete(.passwordFieldIsSmall)
            
            return
        }
        
        self.model.signIn(
            email: self.email,
            passsword: self.password,
            didComplete: didComplete,
            didNotComplete: didNotComplete
        )
    }
    
    func goToCafeMap() -> PlacesMapView {
        return self.coordinator?.goToCafeMap() ?? PlacesMapView(viewModel: PlacesMapViewModel(model: PlacesMapModel(dataManager: DataManager(), locationManager: LocationManager.shared)))
    }
    
}
