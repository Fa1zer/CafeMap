//
//  PlaceInformationViewModel.swift
//  PlacesMap
//
//  Created by Artemiy Zuzin on 08.05.2022.
//

import Foundation

final class PlaceInformationViewModel: ObservableObject, Coordinatable {
    
    var coordinator: NavigationCoordinator?
    
    private let model = PlaceInformationModel()
    
}
