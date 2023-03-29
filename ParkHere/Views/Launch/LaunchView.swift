//
//  LaunchView.swift
//  ParkHere
//
//  Created by Michał Jabłoński on 11/03/2023.
//

import SwiftUI

struct LaunchView: View {
    @EnvironmentObject var auth: AuthManager
    var body: some View {
        NavigationStack {
            VStack {
                
                // MARK: Top bar
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
              
                
                Image("city")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 400)
                
                
                Spacer()
                
                
                // MARK: Buttons
                VStack {
                    NavigationLink { RegisterView() }
                    label: {
                        Text("Create account")
                            .fontWeight(.semibold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color.customGrey)
                            .cornerRadius(10)
                    }

                    
                    
                    NavigationLink { LoginView() }
                    label: {
                        Text("I already have an account")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.secondary)
                            .fontWeight(.semibold)
                            .background(.white)
                            .cornerRadius(10)
                            .shadow(radius: 1)
                    }
                    
                   
                    
                    
                    Button("Start as a guest") { Task { await auth.loginAnonymously() } }
                        .buttonStyle(.launch)
                }
               
               
            }
            .padding()
        .padding(.horizontal)
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
            .environmentObject(AuthManager())
    }
}
