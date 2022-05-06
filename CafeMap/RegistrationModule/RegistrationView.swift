//
//  ContentView.swift
//  CafeMap
//
//  Created by Artemiy Zuzin on 04.05.2022.
//

import SwiftUI

struct RegistrationView: View {
    
    @ObservedObject private var viewModel: RegistrationViewModel
    
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
    }
    
    @State private var signInCompletionStatus = false
    @State private var logInCompletionStatus = false
    @State private var logInError: LogInErrors?
    @State private var signInError: SignInErrors?
    @State private var cafeMapViewIsPresented = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .center, spacing: 20) {
                    Spacer()
                    
                    Image("logo")
                        .resizable()
                        .frame(width: 100, height: 100)
                    
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 0.5) {
                        TextField("Email", text: $viewModel.email)
                            .padding()
                            .frame(height: 50)
                            .background(Color(uiColor: .systemGray6))
                        SecureField(NSLocalizedString("Password", comment: ""), text: $viewModel.password)
                            .padding()
                            .frame(height: 50)
                            .background(Color(uiColor: .systemGray6))
                    }
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(
                        .gray,
                        lineWidth: 0.5
                    ))
                    .background(.gray)
                    .padding([.leading, .trailing], 15)
                    
                    Button {
                        self.viewModel.logIn {
                            self.cafeMapViewIsPresented = true
                        } didNotComplete: { error in
                            self.logInCompletionStatus = true
                            self.logInError = error
                        }
                    } label: {
                        Text(NSLocalizedString("Log In", comment: ""))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 50)
                            .background(.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding([.leading, .trailing], 15)
                    .cornerRadius(10)
                    .alert(isPresented: $logInCompletionStatus) {
                        var title = ""
                        
                        if self.logInError == .passwordFieldIsSmall {
                            title = "Too short a password"
                        } else  {
                            title = "Unable to register"
                        }
                        
                        return Alert(title: Text(NSLocalizedString(title, comment: "")), message: nil, dismissButton: .cancel(Text("OK")))
                    }
                    
                    Button {
                        self.viewModel.signIn {
                            self.cafeMapViewIsPresented = true
                        } didNotComplete: { error in
                            self.signInCompletionStatus = true
                            self.signInError = error
                        }
                    } label: {
                        Text(NSLocalizedString("Sign In", comment: ""))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(.black)
                    }
                    .padding([.leading, .trailing], 15)
                    .alert(isPresented: $signInCompletionStatus) {
                        var title = ""
                        
                        if self.signInError == .passwordFieldIsSmall {
                            title = "Too short a password"
                        } else  {
                            title = "User isn't registered"
                        }
                        
                        return Alert(title: Text(NSLocalizedString(title, comment: "")), message: nil, dismissButton: .cancel(Text("OK")))
                    }
                    
                    Spacer()
                    
                    NavigationLink("",
                                   destination: self.viewModel.goToCafeMap(),
                                   isActive: $cafeMapViewIsPresented)
                        .hidden()
                }
                .frame(height: 700)
            }
            .navigationBarHidden(true)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(viewModel: RegistrationViewModel())
    }
}
