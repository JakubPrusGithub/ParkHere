//
//  ContentView.swift
//  ParkHere
//
//  Created by jabko on 30/03/2023.
//

import SwiftUI


struct ContentView: View {
    @StateObject private var vm = AuthManager()

    var body: some View {
        if vm.logIn {
            AppView()
                .environmentObject(vm)
        } else {
            LaunchView()
                .environmentObject(vm)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
