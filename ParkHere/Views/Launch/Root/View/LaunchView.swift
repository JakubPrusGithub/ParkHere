//
//  LaunchView.swift
//  ParkHere
//
//  Created by Michał Jabłoński on 11/03/2023.
//

import SwiftUI

struct LaunchView: View {
    @StateObject private var vm = LaunchViewVM()
    init() { _ = Dependencies() }
    
    var body: some View {
        NavigationStack {
            VStack {
                // MARK: Top bar
                headerLaunch
                
                // MARK: Image
                image
                
                // MARK: Buttons
                navigationButtons
                
            }
            .padding()
            .padding(.horizontal)
            
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}


extension LaunchView {
    
    private var headerLaunch: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 120, maxHeight: 120)
            
            
            Text("Find your parking spot")
                .font(.title)
                .fontWeight(.semibold)
            
            
            Text("park wherever you want")
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
        }
    }
    
    private var image: some View {
        Image("city")
            .resizable()
            .scaledToFit()
            .frame(maxHeight: 400)
        
    }
    
    private var navigationButtons: some View {
        VStack {
            CustomNavLink(destination: RegisterView(),
                          title: "Create account",
                          type: .dark)
            
            CustomNavLink(destination: LoginView(),
                          title: "I already have an account")
            
            Button("Start as a guest") {
                Task { try await vm.singAnonymously() }
            }
            .customBackground(type: .light)
        }
    }
    
}
