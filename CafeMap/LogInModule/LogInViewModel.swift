//
//  LogInViewModel.swift
//  CafeMap
//
//  Created by Artemiy Zuzin on 04.05.2022.
//

import Foundation
import Combine

final class LogInViewModel: ObservableObject {
    
    @Published var password = ""
    @Published var email = ""
    
    private let logInModel = LogInModel()
    
    func logIn(didComplete: @escaping () -> Void, didNotComplete: @escaping (LogInErrors) -> Void) {
        if password.count < 6 {
            didNotComplete(.passwordFieldIsSmall)
            
            return
        }
        
        self.logInModel.logIn(
            email: self.email,
            passsword: self.password,
            didComplete: didComplete,
            didNotComplete: didNotComplete
        )
    }
    
    func signIn(didComplete: @escaping () -> Void, didNotComplete: @escaping (SignInErrors) -> Void) {
        if password.count < 6 {
            didNotComplete(.passwordFieldIsSmall)
            
            return
        }
        
        self.logInModel.signIn(
            email: self.email,
            passsword: self.password,
            didComplete: didComplete,
            didNotComplete: didNotComplete
        )
    }
    
}
