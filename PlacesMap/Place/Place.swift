//
//  Place.swift
//  PlacesMap
//
//  Created by Artemiy Zuzin on 09.05.2022.
//

import Foundation

struct Place: Decodable, Identifiable {
    let id: UUID
    var name: String
    var imageName: String
    var street: String
    var description: String
}
