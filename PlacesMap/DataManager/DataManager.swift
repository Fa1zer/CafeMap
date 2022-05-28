//
//  DataManager.swift
//  PlacesMap
//
//  Created by Artemiy Zuzin on 19.05.2022.
//

import Foundation
import Combine

final class DataManager: ObservableObject {
    
    private let urlConstructor = URLConstructor.default
    private var userID: UUID?
        
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
    
    func getAllUserPlaces() -> AnyPublisher<[Place], Never> {
        return URLSession.shared.dataTaskPublisher(for: self.urlConstructor.allUserPlacesURL(userID: self.userID))
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

    func postUser(user: User, didComplete: @escaping () -> Void, didNotComplete: @escaping (LogInErrors) -> Void) {
        var request = URLRequest(url: URLConstructor.default.newUserURL())
                
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(user)
        
        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                
                didNotComplete(.someError)
            } else {
                print("✅ place with id: \(String(describing: user.id)) posted.")
                
                didComplete()
            }
        }
        .resume()
    }
    
    func authUser(user: User, didComplete: @escaping () -> Void, didNotComplete: @escaping (SignInErrors) -> Void) {
        var request = URLRequest(url: URLConstructor.default.authUser())
        
        guard let base64EncodedCredential = "\(user.email):\(String(describing: user.password))".data(using: String.Encoding.utf8)?.base64EncodedString() else { return }
        
        let authString = "Basic \(base64EncodedCredential)"
        let urlSessionConfiguration = URLSessionConfiguration.default
        
        urlSessionConfiguration.httpAdditionalHeaders = ["Authorization" : authString]
        
        request.setValue(authString, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                
                didNotComplete(.someError)
            }
            
            guard let data = data else {
                print("❌ Error: data is equal to nil.")
                
                didNotComplete(.someError)
                
                return
            }
                        
            guard let user = try? JSONDecoder().decode(HashUser.self, from: data) else {
                print("❌Error: Decoding failed.")
                
                didNotComplete(.someError)
                
                return
            }
            
            print("✅ place with id: \(String(describing: user.id)) authenticated.")
            
            didComplete()
            
            self.userID = user.id
        }
        .resume()
    }
    
    func postPlace(place: Place) {
        var newPlace = place
        
        newPlace.userID = self.userID ?? UUID()
        
        var request = URLRequest(url: URLConstructor.default.newPlaceURL())
        
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(newPlace)
        
        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
            } else {
                print("✅ place with id: \(String(describing: place.name) ) posted.")
            }
        }
        .resume()
    }
    
    func putPlace(place: Place) {
        var request = URLRequest(url: URLConstructor.default.putPlaceURL())
        
        print(URLConstructor.default.putPlaceURL())
        
        request.httpMethod = HTTPMethod.put.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(place)
        
        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
            } else {
                print("✅ place with id: \(String(describing: place.name) ) changed.")
            }
        }
        .resume()
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
        .resume()
    }
    
    private enum HTTPMethod: String {
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
}
