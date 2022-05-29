//
//  LogInModel.swift
//  CafeMap
//
//  Created by Artemiy Zuzin on 04.05.2022.
//

import Foundation
import Combine

final class RegistrationModel {
    
    private let dataManager: DataManager
    private let keychainManager: KeychainManager?
    
    init(dataManager: DataManager, keychainManager: KeychainManager? = nil) {
        self.dataManager = dataManager
        self.keychainManager = keychainManager
    }
    
    func logIn(email: String, passsword: String, didComplete: @escaping () -> Void, didNotComplete: @escaping (LogInErrors) -> Void) {
        self.dataManager.postUser(
            user: User(email: email, password: passsword),
            didComplete: {
                self.signIn(email: email, passsword: passsword, didComplete: didComplete, didNotComplete: { _ in didNotComplete(.someError) })
            },
            didNotComplete: didNotComplete
        )
    }
    
    func signIn(email: String, passsword: String, didComplete: @escaping () -> Void, didNotComplete: @escaping (SignInErrors) -> Void) {
        let newDidComplete = {
            didComplete()
            
            self.keychainManager?.setEmailAndPassword(email: email, password: passsword)
        }
        
        self.dataManager.authUser(user: User(email: email, password: passsword), didComplete: newDidComplete, didNotComplete: didNotComplete)
    }
    
    func keychainSignIn(didComplete: @escaping () -> Void) {
        guard let (email, password) = self.keychainManager?.getEmailAndPassword() else { return }
        
        self.dataManager.authUser(user: User(email: email, password: password), didComplete: didComplete, didNotComplete: { _ in })
    }
    
}
