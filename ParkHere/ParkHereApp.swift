//
//  ParkHereApp.swift
//  ParkHere
//
//  Created by Jakub Prus on 06/03/2023.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct ParkHereApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var authManager = AuthManager()
    
    var body: some Scene {
        WindowGroup {
            if authManager.login {
                AppView()
            } else {
                LaunchView()
            }
        }
        
    }
}

