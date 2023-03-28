//
//  AppView.swift
//  ParkHere
//
//  Created by jabko on 28/03/2023.
//

import SwiftUI

struct AppView: View {
    @State private var selection: TabBarItem = .map
    
    var body: some View {
        CustomTabBarContainterView(selection: $selection) {
            
            TicketView()
                .tabBarItem(tab: .ticket, selection: $selection)
            
            MainMapView()
                .tabBarItem(tab: .map, selection: $selection)
            
            HistoryView()
                .tabBarItem(tab: .history, selection: $selection)
            
            ProfilView()
                .tabBarItem(tab: .profile, selection: $selection)
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
