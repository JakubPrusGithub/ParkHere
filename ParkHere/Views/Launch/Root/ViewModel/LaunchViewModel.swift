//
//  LaunchViewModel.swift
//  ParkHere
//
//  Created by jabko on 28/03/2023.
//

import Foundation


class LaunchViewVM: ObservableObject {
    @Inject var authManager: AuthManager
    
    //MARK: Function
    func singAnonymously() async throws {
        try await authManager.loginAnonymously()
    }
}
