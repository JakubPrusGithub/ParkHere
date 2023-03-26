//
//  ParkHereApp.swift
//  ParkHere
//
//  Created by Jakub Prus on 06/03/2023.
//

import SwiftUI
import FirebaseCore
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
    
    @StateObject private var auth = AuthManager()
    @State private var selectedTab: Tab = .map
    
    var body: some Scene {
        WindowGroup {
            //MainMapView(selectedTab: $selectedTab)
            AddTestTicketView()
//            if auth.user == nil {
//                LoginView()
//                    .environmentObject(auth)
//            } else {
//                switch selectedTab {
//                case .ticket:
//                    TicketView(selectedTab: $selectedTab)
//                        .environmentObject(auth)
//                case .map:
//                    MainMapView(selectedTab: $selectedTab)
//                        .environmentObject(auth)
//                case .profil:
//                    ProfilView(selectedTab: $selectedTab)
//                        .environmentObject(auth)
//                }
//            }
        }
    }
}
