//
//  AuthManager.swift
//  ParkHere
//
//  Created by jabko on 12/03/2023.
//

import Foundation
import Firebase
import GoogleSignIn


struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}



class AuthManager: ObservableObject {
    let auth = Auth.auth()
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = auth.currentUser else { throw URLError(.fileDoesNotExist) }
        return AuthDataResultModel(user: user)
    }
}


// MARK: SIGN IN ANONYMOUSLY
extension AuthManager {
    
    @MainActor @discardableResult
    func loginAnonymously() async throws -> AuthDataResultModel {
        let authDataResult = try await auth.signInAnonymously()
        return AuthDataResultModel(user: authDataResult.user)
    }
    
}


// MARK: SING IN/UP - EMAIL
extension AuthManager {
    
    @MainActor @discardableResult
    func signUp(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await auth.createUser(withEmail: email, password: password)
        print("Success")
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    
    @MainActor @discardableResult
    func signIn(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await auth.signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    @MainActor
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
}



// MARK: SING IN - SSO
extension AuthManager {
    
    @MainActor @discardableResult
    func singInWithGoogle(token: GoogleSignInResultModel) async throws -> AuthDataResultModel{
        let credential = GoogleAuthProvider.credential(withIDToken: token.idToken, accessToken: token.accessToken)
        return try await signIn(credential: credential)
    }
    
    @MainActor
    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().signIn(with: credential)
        print("Success")
        return AuthDataResultModel(user: authDataResult.user)
    }
}




// MARK: SING OUT
extension AuthManager {
    func singOut() throws {
        try auth.signOut()
    }
}

