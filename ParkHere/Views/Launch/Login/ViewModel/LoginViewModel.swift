//
//  LoginViewModel.swift
//  ParkHere
//
//  Created by jabko on 28/03/2023.
//

import Foundation

@MainActor
class LoginViewVM: ObservableObject {
    @Inject var authManager: AuthManager
    
    @Published var email: String = ""
    @Published var password: String = ""
   
    
}

// MARK: AuthManager functions
extension LoginViewVM {
//    @MainActor
    func signIn() async throws {
        try await authManager.signIn(email: email, password: password)
    }
    
//    @MainActor
    func resetPassword() async throws {
        try await authManager.resetPassword(email: email)
    }
    
//    @MainActor
    func singInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.singIn()
        try await authManager.singInWithGoogle(token: tokens)
    }
}
