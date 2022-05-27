//
//  RedactPlaceModel.swift
//  PlacesMap
//
//  Created by Artemiy Zuzin on 09.05.2022.
//

import Foundation

final class RedactPlaceModel: ObservableObject {
    
    private let dataManger: DataManager
    
    init(dataManager: DataManager) {
        self.dataManger = dataManager
    }
    
    @Published var name = ""
    @Published var street = ""
    @Published var description = ""
    @Published var imageName = ""
    
    func saveChanges() {
        print(#function)
    }
    
    func deletePlace() {
        print(#function)
    }

}
