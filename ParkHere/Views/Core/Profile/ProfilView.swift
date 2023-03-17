//
//  ProfilView.swift
//  ParkHere
//
//  Created by jabko on 17/03/2023.
//

import SwiftUI

struct ProfilView: View {
    @Binding var selectedTab: Tab
    var body: some View {
        ZStack {
            Text("Profil View")
            TabBarView(selectedTab: $selectedTab)
        } // ZStack
    }
}

struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilView(selectedTab: .constant(.profil))
    }
}
