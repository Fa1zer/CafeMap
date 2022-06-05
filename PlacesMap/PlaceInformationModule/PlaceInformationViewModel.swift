//
//  PlaceInformationViewModel.swift
//  PlacesMap
//
//  Created by Artemiy Zuzin on 08.05.2022.
//

import Foundation
import UIKit

final class PlaceInformationViewModel: ObservableObject, Coordinatable {
    
    private let model: PlaceInformationModel
    
    init(model: PlaceInformationModel) {
        self.model = model
    }
    
    var coordinator: NavigationCoordinator?
    var name: String { self.model.place.name }
    var street: String { self.model.place.street }
    var description: String { self.model.place.placeDescription }
    var image: UIImage { UIImage(data: Data(base64Encoded: self.model.place.image ?? "") ?? Data()) ?? (UIImage(named: "empty") ?? UIImage()) }
    
}
