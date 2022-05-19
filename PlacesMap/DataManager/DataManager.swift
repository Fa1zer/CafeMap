//
//  DataManager.swift
//  PlacesMap
//
//  Created by Artemiy Zuzin on 19.05.2022.
//

import Foundation
import Combine

final class DataManager: ObservableObject {
    
    @Published var places = URLSession.shared.dataTaskPublisher(for: URLConstructor.default.allPlacesURL())
        .tryMap { response -> Data in
            guard let httpResponse = response.response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else { throw URLError(.badServerResponse) }
            
            return response.data
        }
        .decode(type: [Place].self, decoder: JSONDecoder())
        .replaceError(with: [Place]())
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    
    var userID: UUID?
    
    func getUser(userID: UUID) {
        URLSession.shared.dataTask(with: URLConstructor.default.userURL(userID: userID)) { data, _, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
            }
            
            guard let data = data else {
                print("❌ Error: Data is equal to nil")
                
                return
            }
            
            guard let user = try? JSONDecoder().decode(User.self, from: data) else {
                print("❌ Error: Decode error")
                
                return
            }
            
            if user.id == userID { self.userID = userID }
        }
        .resume()
    }
    
    func getAllUserPlaces() -> AnyPublisher<[Place], Never> {
        return URLSession.shared.dataTaskPublisher(for: URLConstructor.default.allUserPlacesURL(userID: self.userID ?? UUID()))
            .tryMap { response -> Data in
                guard let httpResponse = response.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else { throw URLError(.badServerResponse) }
                
                return response.data
            }
            .decode(type: [Place].self, decoder: JSONDecoder())
            .replaceError(with: [Place]())
            .receive(on: RunLoop.main)
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
