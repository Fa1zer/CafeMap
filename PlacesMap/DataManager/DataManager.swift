//
//  DataManager.swift
//  PlacesMap
//
//  Created by Artemiy Zuzin on 19.05.2022.
//

import Foundation
import Combine

final class DataManager {
        
    private let urlConstructor = URLConstructor.default
    
    func getAllPlaces() -> AnyPublisher<[Place], Never> {
        return URLSession.shared.dataTaskPublisher(for: self.urlConstructor.allPlacesURL())
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else { throw URLError(.badServerResponse) }
                
                return element.data
            }
            .decode(type: [Place].self, decoder: JSONDecoder())
            .replaceError(with: [Place]())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func getAllUserPlaces(userID: UUID?) -> AnyPublisher<[Place], Never> {
        return URLSession.shared.dataTaskPublisher(for: self.urlConstructor.allUserPlacesURL(userID: userID))
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else { throw URLError(.badServerResponse) }
                
                return element.data
            }
            .decode(type: [Place].self, decoder: JSONDecoder())
            .replaceError(with: [Place]())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func postPlace(place: Place) {
        var request = URLRequest(url: URLConstructor.default.allPlacesURL())
        
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(place)
        
        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
            } else {
                print("✅ place with id: \(place.id) posted.")
            }
        }
    }
    
    func putPlace(place: Place) {
        var request = URLRequest(url: URLConstructor.default.allPlacesURL())
        
        request.httpMethod = HTTPMethod.put.rawValue
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(place)
        
        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
            } else {
                print("✅ place with id: \(place.id) changed.")
            }
        }
    }
    
    func deletePlace(placeID: UUID) {
        var request = URLRequest(url: URLConstructor.default.placeURL(placeID: placeID))
        
        request.httpMethod = HTTPMethod.delete.rawValue
        
        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
            } else {
                print("✅ place with id: \(placeID) deleted.")
            }
        }
    }
    
    private enum HTTPMethod: String {
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
}
