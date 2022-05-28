//
//  User.swift
//  PlacesMap
//
//  Created by Artemiy Zuzin on 17.05.2022.
//

import Foundation

struct User: Identifiable, Codable {
    var id: UUID?
    var email: String
    var password: String
}

struct HashUser: Identifiable, Codable {
    var id: UUID?
    var email: String
    var passwordHash: String
}
