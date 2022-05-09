//
//  LogInModel.swift
//  CafeMap
//
//  Created by Artemiy Zuzin on 04.05.2022.
//

import Foundation
import Combine
import FirebaseAuth

final class RegistrationModel {
    
    func logIn(email: String, passsword: String, didComplete: @escaping () -> Void, didNotComplete: @escaping (LogInErrors) -> Void) {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: passsword) { result, error in
            if let error = error {
                didNotComplete(.someError)
                
                print("❌ Error: \(error.localizedDescription)")
                
                return
            }
            
            didComplete()
        }
    }
    
    func signIn(email: String, passsword: String, didComplete: @escaping () -> Void, didNotComplete: @escaping (SignInErrors) -> Void) {
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: passsword) { _, error in
            if let error = error {
                didNotComplete(.someError)
                
                print("❌ Error: \(error.localizedDescription)")

                return
            }
            
            didComplete()
        }
    }
    
}
