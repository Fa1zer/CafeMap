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
    }
    
    func signIn(email: String, passsword: String, didComplete: @escaping () -> Void, didNotComplete: @escaping (SignInErrors) -> Void) {
        self.dataManager.authUser(user: User(email: email, password: passsword), didComplete: didComplete, didNotComplete: didNotComplete)
    }
    
}
