//
//  TicketView.swift
//  ParkHere
//
//  Created by jabko on 17/03/2023.
//

import SwiftUI

struct TicketView: View {
    @Binding var selectedTab: Tab
    var body: some View {
        ZStack {
            Text("Ticket View")
            TabBarView(selectedTab: $selectedTab)
        } // ZStack
    }
}

struct TicketView_Previews: PreviewProvider {
    static var previews: some View {
        TicketView(selectedTab: .constant(.ticket))
    }
}
