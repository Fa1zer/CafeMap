//
//  URLConstructor.swift
//  PlacesMap
//
//  Created by Artemiy Zuzin on 18.05.2022.
//

import Foundation

final class URLConstructor {
    
    private let baseURL: String
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    private init() {
        self.baseURL = "http://127.0.0.1:8080/"
    }
    
    static let `default` = URLConstructor()
        
    func allUsersURL() -> URL {
        return URL(string: self.baseURL)?
            .appendingPathComponent(URLPaths.users.rawValue) ?? URL(fileURLWithPath: "")
    }
    
    func newUserURL() -> URL {
        return URL(string: self.baseURL)?
            .appendingPathComponent(URLPaths.users.rawValue)
            .appendingPathComponent(URLPaths.new.rawValue) ?? URL(fileURLWithPath: "")
    }
    
    func userURL(userID: UUID?) -> URL {
        guard let userID = userID else {
            return URL(fileURLWithPath: "")
        }
        
        return URL(string: self.baseURL)?
            .appendingPathComponent(URLPaths.users.rawValue)
            .appendingPathComponent(userID.uuidString) ?? URL(fileURLWithPath: "")
    }
    
    func authUser() -> URL {
        return URL(string: self.baseURL)?
            .appendingPathComponent(URLPaths.user.rawValue)
            .appendingPathComponent(URLPaths.auth.rawValue) ?? URL(fileURLWithPath: "")
    }
    
    func allUserPlacesURL(userID: UUID?) -> URL {
        guard let userID = userID else {
            return URL(fileURLWithPath: "")
        }

        
        return URL(string: self.baseURL)?
            .appendingPathComponent(URLPaths.users.rawValue)
            .appendingPathComponent(userID.uuidString)
            .appendingPathComponent(URLPaths.places.rawValue) ?? URL(fileURLWithPath: "")
    }
    
    func allPlacesURL() -> URL {
        return URL(string: self.baseURL)?
            .appendingPathComponent(URLPaths.places.rawValue) ?? URL(fileURLWithPath: "")
    }
    
    func putPlaceURL() -> URL {
        return URL(string: self.baseURL)?
            .appendingPathComponent(URLPaths.places.rawValue)
            .appendingPathComponent(URLPaths.redact.rawValue) ?? URL(fileURLWithPath: "")
    }
    
    func newPlaceURL() -> URL {
        return URL(string: self.baseURL)?
            .appendingPathComponent(URLPaths.places.rawValue)
            .appendingPathComponent(URLPaths.new.rawValue) ?? URL(fileURLWithPath: "")
    }
    
    func placeURL(placeID: UUID?) -> URL {
        guard let placeID = placeID else {
            return URL(fileURLWithPath: "")
        }

        return URL(string: self.baseURL)?
            .appendingPathComponent(URLPaths.places.rawValue)
            .appendingPathComponent(placeID.uuidString) ?? URL(fileURLWithPath: "")
    }
    
    func placeUserURL(placeID: UUID?) -> URL {
        guard let placeID = placeID else {
            return URL(fileURLWithPath: "")
        }
        
        return URL(string: self.baseURL)?
            .appendingPathComponent(URLPaths.places.rawValue)
            .appendingPathComponent(placeID.uuidString)
            .appendingPathComponent(URLPaths.user.rawValue) ?? URL(fileURLWithPath: "")
    }
    
    private enum URLPaths: String {
        case users, places, user, new, auth, redact
    }
    
}
