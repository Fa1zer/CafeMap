//
//  AddPlaceViewModel.swift
//  PlacesMap
//
//  Created by Artemiy Zuzin on 23.05.2022.
//

import Foundation
import CoreLocation
import Combine
import MapKit
import SwiftUI

final class AddPlaceViewModel: ObservableObject, Coordinatable {
    
    @ObservedObject private var model: AddPlaceModel
    
    init(model: AddPlaceModel) {
        self.model = model
        
        self.model.$coordinateRegion
            .assign(to: \.coordinateRegion, on: self)
            .store(in: &self.subribtions)
        self.$name
            .assign(to: &self.model.$name)
        self.$street
            .assign(to: &self.model.$street)
        self.$description
            .assign(to: &self.model.$description)
        self.$imageName
            .assign(to: &self.model.$imageName)
    }
    
    var coordinator: NavigationCoordinator?
    @Published var coordinateRegion = MKCoordinateRegion()
    @Published var name = ""
    @Published var street = ""
    @Published var description = ""
    @Published var imageName = ""
    @Published var lat: Float = 0
    @Published var lon: Float = 0
    
    private var subribtions: Set<AnyCancellable> = []
    
    func getUserLocation() {
        self.model.getUserLocation()
    }
    
    func saveChanges() {
        self.model.saveChanges()
    }
    
    func deletePlace() {
        self.model.deletePlace()
    }
    
    func goToMyPlaces() -> MyPlacesView {
        return self.coordinator?.goToMyPlaces() ?? MyPlacesView(viewModel: MyPlacesViewModel(model: MyPlacesModel(dataManager: DataManager())))
    }
    
}
