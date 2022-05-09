//
//  RedactPlaceViewModel.swift
//  PlacesMap
//
//  Created by Artemiy Zuzin on 09.05.2022.
//

import Foundation

final class RedactPlaceViewModel: ObservableObject, Coordinatable {
    
    init() {
        self.$name
            .assign(to: &self.model.$name)
        self.$street
            .assign(to: &self.model.$street)
        self.$description
            .assign(to: &self.model.$description)
        self.$imageName
            .assign(to: &self.model.$imageName)
    }
    
    @Published var name = ""
    @Published var street = ""
    @Published var description = ""
    @Published var imageName = ""
    
    var coordinator: NavigationCoordinator?
    
    private let model = RedactPlaceModel()
    
    func saveChanges() {
        self.model.saveChanges()
    }
    
    func deletePlace() {
        self.model.deletePlace()
    }
    
    func goToMyPlaces() -> MyPlacesView {
        return self.coordinator?.goToMyPlaces() ?? MyPlacesView(viewModel: MyPlacesViewModel())
    }
    
}
