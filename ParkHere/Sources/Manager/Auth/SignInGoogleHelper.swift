//
//  SignInGoogleHelper.swift
//  ParkHere
//
//  Created by jabko on 28/03/2023.
//

import Foundation
import Firebase
import GoogleSignIn
import GoogleSignInSwift


struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
    
}

@MainActor
final class SignInGoogleHelper {
    
    func singIn() async throws  -> GoogleSignInResultModel {
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController
        else { throw URLError(.fileDoesNotExist) }
        
        guard let id = FirebaseApp.app()?.options.clientID else { throw URLError(.fileDoesNotExist) }
        let config = GIDConfiguration(clientID: id)
        GIDSignIn.sharedInstance.configuration = config
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController)
    
        guard let idToken = gidSignInResult.user.idToken?.tokenString else { throw URLError(.fileDoesNotExist) }
        let accessToken = gidSignInResult.user.accessToken.tokenString
        
        let token = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)
        return token
    }
}
