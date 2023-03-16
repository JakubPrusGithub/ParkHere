//
//  TabBarView.swift
//  ParkHere
//
//  Created by jabko on 16/03/2023.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case chat = "chat"
    case phone = "phone"
    case group = "users"
    case settings = "settings"
}

struct TabBarView: View {
    @Binding var selectedTab: Tab
    private var fillImage: String { selectedTab.rawValue }
    
    var body: some View {
        HStack {
            ForEach(Tab.allCases, id: \.self) { tab in
                Spacer()
                Image(selectedTab == tab ? fillImage : tab.rawValue)
                    .resizable()
                    .renderingMode(.template)
                    .frame(maxWidth: 20, maxHeight: 20)
                    .scaleEffect(selectedTab == tab ? 1.1 : 1.0)
                    .foregroundColor(selectedTab == tab ? .black : .secondary.opacity(0.5))
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            selectedTab = tab
                        }
                    }
                Spacer()
            }
        }
        .padding()
        .background(Color.blue)
        .cornerRadius(20)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(selectedTab: .constant(.chat))
    }
}
