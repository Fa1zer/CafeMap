//
//  LogInModel.swift
//  CafeMap
//
//  Created by Artemiy Zuzin on 04.05.2022.
//

import Foundation
import Combine
//import FirebaseAuth

final class RegistrationModel {
    
    private let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func logIn(email: String, passsword: String, didComplete: @escaping () -> Void, didNotComplete: @escaping (LogInErrors) -> Void) {
        self.dataManager.postUser(
            user: User(email: email, password: passsword),
            didComplete: {
                self.signIn(email: email, passsword: passsword, didComplete: didComplete, didNotComplete: { _ in didNotComplete(.someError) })
            },
            didNotComplete: didNotComplete
        )
        
//        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: passsword) { result, error in
//            if let error = error {
//                didNotComplete(.someError)
//
//                print("❌ Error: \(error.localizedDescription)")
//
//                return
//            }
//
//            self.dataManager.postUser(user: User(email: email, password: passsword))
//
//            didComplete()
//        }
    }
    
    func signIn(email: String, passsword: String, didComplete: @escaping () -> Void, didNotComplete: @escaping (SignInErrors) -> Void) {
        self.dataManager.authUser(user: User(email: email, password: passsword), didComplete: didComplete, didNotComplete: didNotComplete)
        
//        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: passsword) { _, error in
//            if let error = error {
//                didNotComplete(.someError)
//
//                print("❌ Error: \(error.localizedDescription)")
//
//                return
//            }
//
//            didComplete()
//        }
    }
    
}
