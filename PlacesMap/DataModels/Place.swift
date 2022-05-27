//
//  Place.swift
//  PlacesMap
//
//  Created by Artemiy Zuzin on 17.05.2022.
//

import Foundation

struct Place: Codable, Identifiable {
    
    let id: String
    var name: String
    var street: String
    var placeDescription: String
    var lat: Float
    var lon: Float
    var image: Data?
    var user: User
    
}
