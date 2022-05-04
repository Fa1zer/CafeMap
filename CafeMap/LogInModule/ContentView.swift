//
//  ContentView.swift
//  CafeMap
//
//  Created by Artemiy Zuzin on 04.05.2022.
//

import SwiftUI

struct ContentView: View {
    
    private enum CompletionStatus {
        case sucsesed, unsucsesed
    }
    
    @ObservedObject private var viewModel: LogInViewModel
    
    @State private var signInCompletionStatus = false
    @State private var logInCompletionStatus = false
    @State private var completionStatus: CompletionStatus?

    
    init(viewModel: LogInViewModel) {
        self.viewModel = viewModel
    }
    
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
                        SecureField("Password", text: $viewModel.password)
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
                            self.completionStatus = .sucsesed
                            self.logInCompletionStatus = true
                        } didNotComplete: {
                            self.completionStatus = .unsucsesed
                            self.logInCompletionStatus = true
                        }

                    } label: {
                        Text("Log In")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 50)
                            .background(.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding([.leading, .trailing], 15)
                    .cornerRadius(10)
                    .alert(isPresented: $logInCompletionStatus) {
                        if self.completionStatus == .sucsesed {
                            return Alert(title: Text("Loged In"), message: nil, dismissButton: .cancel(Text("OK")))
                        }
                        return Alert(title: Text("Error"), message: nil, dismissButton: .cancel(Text("OK")))
                    }
                    
                    Button {
                        self.viewModel.signIn {
                            self.completionStatus = .sucsesed
                            self.signInCompletionStatus = true
                        } didNotComplete: {
                            self.completionStatus = .unsucsesed
                            self.signInCompletionStatus = true
                        }

                    } label: {
                        Text("Sign In")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(.black)
                    }
                    .padding([.leading, .trailing], 15)
                    .alert(isPresented: $signInCompletionStatus) {
                        if self.completionStatus == .sucsesed {
                            return Alert(title: Text("Signed In"), message: nil, dismissButton: .cancel(Text("OK")))
                        }
                        return Alert(title: Text("User isn't registered"), message: nil, dismissButton: .cancel(Text("OK")))
                    }
                    
                    Spacer()
                }
                .frame(height: 700)
            }
            .navigationBarHidden(true)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: LogInViewModel())
    }
}
