//
//  PlaceInformationViewModel.swift
//  PlacesMap
//
//  Created by Artemiy Zuzin on 08.05.2022.
//

import Foundation

final class PlaceInformationViewModel: ObservableObject, Coordinatable {
    
    private let model: PlaceInformationModel
    
    init(model: PlaceInformationModel) {
        self.model = model
    }
    
    var coordinator: NavigationCoordinator?
    
}
