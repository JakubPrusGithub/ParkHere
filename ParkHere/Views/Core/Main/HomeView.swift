//
//  HomeView.swift
//  ParkHere
//
//  Created by Michał Jabłoński on 11/03/2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var auth: AuthManager
    var body: some View {
        VStack {
            Text("Sing out")
                .fontWeight(.semibold)
                .onTapGesture {
                    Task { await auth.singOut() }
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AuthManager())
    }
}
