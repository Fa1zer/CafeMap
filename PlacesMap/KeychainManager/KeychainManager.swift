//
//  KeyChainManager.swift
//  PlacesMap
//
//  Created by Artemiy Zuzin on 29.05.2022.
//

import Foundation
import KeychainAccess

final class KeychainManager {
    
    private let keychain = Keychain(service: "artemiy.CafeMap")
    
    func getEmailAndPassword() -> (email: String, password: String)? {
        guard let email = self.keychain["email"], let password = self.keychain["password"] else { return nil }
        
        return (email: email, password: password)
    }
    
    func setEmailAndPassword(email: String, password: String) {
        self.keychain["email"] = email
        self.keychain["password"] = password
    }
    
}
