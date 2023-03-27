//
//  TabBarView.swift
//  ParkHere
//
//  Created by jabko on 16/03/2023.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case ticket = "ticket"
    case map = "map"
    case profil = "profil"
}

struct TabBarView: View {
    @Binding var selectedTab: Tab
    private var fillImage: String { selectedTab.rawValue }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            HStack {
                ForEach(Tab.allCases, id: \.self) { tab in
                    
                    Spacer()
                    VStack {
                        Image(selectedTab == tab ? fillImage : tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .frame(maxWidth: 25, maxHeight: 25)
                            .scaleEffect(selectedTab == tab ? 1.1 : 1.0)
                            .foregroundColor(selectedTab == tab ? .black : .gray)
                            .onTapGesture {
                                withAnimation(.easeInOut) { selectedTab = tab }
                            }
                        
                        Text(tab.rawValue)
//                            .opacity(selectedTab == tab ? 1 : 0)
                            .font(.caption)
                            .fixedSize(horizontal: true, vertical: false)
                            .scaleEffect(selectedTab == tab ? 1.1 : 1.0)
                            .foregroundColor(selectedTab == tab ? .black : .gray)
                    }
                    Spacer()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .fontWeight(.semibold)
            .background(.white)
            .cornerRadius(20)
            .shadow(radius: 1)
            
            .frame(maxHeight: .infinity, alignment: .bottom)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
//        TabBarView(selectedTab: .constant(.home))
        MainMapView(selectedTab: .constant(.map))
    }
}
