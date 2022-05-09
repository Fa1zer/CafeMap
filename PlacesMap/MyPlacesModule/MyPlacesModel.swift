//
//  MyPlacesModel.swift
//  PlacesMap
//
//  Created by Artemiy Zuzin on 09.05.2022.
//

import Foundation

final class MyPlacesModel: ObservableObject {
    
    @Published var places = [Place(id: UUID(), name: "test1", imageName: "logo", street: "street 1", description: "1"),
                             Place(id: UUID(), name: "test2", imageName: "logo", street: "street 2", description: "2")]
    
}
