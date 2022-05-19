//
//  MyPlacesModel.swift
//  PlacesMap
//
//  Created by Artemiy Zuzin on 09.05.2022.
//

import Foundation
import UIKit

final class MyPlacesModel: ObservableObject {
    
    @Published var places = [Place(id: UUID(), name: "1", street: "1", placeDescription: "1", lat: 1, lon: 1, image: UIImage(named: "logo")?.pngData(), user: User(id: UUID()))]
    
}
