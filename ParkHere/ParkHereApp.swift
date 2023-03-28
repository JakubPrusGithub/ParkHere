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
//    @Inject var authManager: AuthManager
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            if Auth.auth().currentUser.self == nil {
                LoginView()
            } else {
                AppView()
            }
        }
    }
}
