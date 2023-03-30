//
//  ProfilViewModel.swift
//  ParkHere
//
//  Created by jabko on 30/03/2023.
//

import Foundation


class ProfilViewModel: ObservableObject {
    @Inject var authManager: AuthManager
    
    
    func singOut() throws {
        try authManager.singOut()
    }
}
