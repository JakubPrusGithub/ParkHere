//
//  CustomTabBarView.swift
//  ParkHere
//
//  Created by jabko on 28/03/2023.
//

import SwiftUI

struct CustomTabBarView: View {
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    @Namespace private var namespace
    @State var localSelection: TabBarItem
    
    var body: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab)
                    .onTapGesture { selection = tab }
                
            }
        }
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(Color.white.ignoresSafeArea(edges: .bottom))
        .onChange(of: selection) { newValue in
            withAnimation(.easeInOut) {
                localSelection = newValue
            }
        }
    }
}


struct CustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
//        CustomTabBarView(tabs: [.map, .profile, .ticket], selection: .constant(.map), localSelection: .map)
        AppView()
    }
}


extension CustomTabBarView {
    private func tabView(tab: TabBarItem) -> some View {
        HStack {
            Image(tab.iconName)
                .flatIconImage()
            
            Text(tab.title)
                .font(.headline)
        }
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .foregroundColor(localSelection == tab ? Color.black : Color.gray)
        .background(
            ZStack {
                if localSelection == tab {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .frame(maxWidth: 50, maxHeight: 1)
                        .matchedGeometryEffect(id: "background_rectangle", in: namespace)
                }
            }
                .frame(maxHeight: .infinity, alignment: .bottom)
        )
    }
}
