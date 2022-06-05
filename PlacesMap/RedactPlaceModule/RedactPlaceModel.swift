//
//  RedactPlaceModel.swift
//  PlacesMap
//
//  Created by Artemiy Zuzin on 09.05.2022.
//

import Foundation
import SwiftUI

final class RedactPlaceModel: ObservableObject {
    
    private let dataManager: DataManager
    @Published var place: Place
    
    init(dataManager: DataManager, place: Place) {
        self.dataManager = dataManager
        self.place = place
    }
        
    func saveChanges(place: Place) {
        self.dataManager.putPlace(place: place)
    }
    
    func deletePlace() {
        self.dataManager.deletePlace(placeID: self.place.id ?? UUID())
    }

}
