//
//  AuthManager.swift
//  ParkHere
//
//  Created by jabko on 12/03/2023.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import GoogleSignIn



class AuthManager: ObservableObject {
    @Published var name: String = ""
    @Published var surname: String = ""
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    @Published var user: User? = nil
    
    let auth = Auth.auth()
}



// MARK: Sign in anonymously
extension AuthManager {
    
    @MainActor
    func loginAnonymously() async {
        do {
            self.user = try await auth.signInAnonymously().user
        } catch {
            print(error.localizedDescription)
        }
    }
    
}


// MARK: Sing up/in with email/password
extension AuthManager {
    
    @MainActor
    func singUp() async {
        do {
            try await auth.createUser(withEmail: email, password: password)
            await singIn()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    @MainActor
    func singIn() async {
        do {
            self.user = try await auth.signIn(withEmail: email, password: password).user
        } catch {
            print(error.localizedDescription)
        }
    }

}


// MARK: Sign in with Google
extension AuthManager {
    @MainActor
    func loginWithGoogle() async {
        do {
            guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController
            else { throw URLError(.notConnectedToInternet) }
            
            guard let id = FirebaseApp.app()?.options.clientID else { return }
            let config = GIDConfiguration(clientID: id)
            GIDSignIn.sharedInstance.configuration = config
        
        
            let SignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController)
        
            guard let idToken = SignInResult.user.idToken?.tokenString
            else { throw URLError(.badServerResponse) }
            
            let accessToken = SignInResult.user.accessToken.tokenString
            
            let credentials = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
           
            self.user = try await auth.signIn(with: credentials).user
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}


// MARK: Sing out
extension AuthManager {
    @MainActor
    func singOut() async {
        do {
            try auth.signOut()
            self.user = nil
        } catch {
            print(error.localizedDescription)
        }
    }
}
