//
//  MyPlacesViewModel.swift
//  PlacesMap
//
//  Created by Artemiy Zuzin on 09.05.2022.
//

import Foundation

final class MyPlacesViewModel: ObservableObject, Coordinatable {
    
    init() {
        self.model.$places
            .assign(to: &self.$places)
    }
    
    @Published var places = [Place]()
    
    var coordinator: NavigationCoordinator?
    
    private let model = MyPlacesModel()
    
    func goToRedactPlace() -> RedactPlaceView {
        return self.coordinator?.goToRedactPlace() ?? RedactPlaceView(viewModel: RedactPlaceViewModel())
    }
    
}
