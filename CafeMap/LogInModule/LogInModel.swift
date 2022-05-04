//
//  LogInModel.swift
//  CafeMap
//
//  Created by Artemiy Zuzin on 04.05.2022.
//

import Foundation
import Combine
import FirebaseAuth

final class LogInModel {
    
    func logIn(email: String, passsword: String, didComplete: @escaping () -> Void, didNotComplete: @escaping () -> Void) {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: passsword) { result, error in
            if let error = error {
                didNotComplete()
                
                print("❌ Error: \(error.localizedDescription)")
            }
            
            didComplete()
        }
    }
    
    func signIn(email: String, passsword: String, didComplete: @escaping () -> Void, didNotComplete: @escaping () -> Void) {
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: passsword) { _, error in
            if let error = error {
                didNotComplete()
                
                print("❌ Error: \(error.localizedDescription)")
            }
            
            didComplete()
        }
    }
    
}
