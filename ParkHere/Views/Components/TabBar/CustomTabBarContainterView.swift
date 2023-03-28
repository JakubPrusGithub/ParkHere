//
//  CustomTabBarContainterView.swift
//  ParkHere
//
//  Created by jabko on 28/03/2023.
//

import SwiftUI

struct CustomTabBarContainterView<Content: View> : View {
    @State private var tabs: [TabBarItem] = []
    @Binding var selection: TabBarItem
    let content: Content
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content() // () because this is functions that ↑ return content
    }
    var body: some View {
        ZStack(alignment: .bottom) {
            content
                .ignoresSafeArea()
            
            CustomTabBarView(tabs: tabs, selection: $selection, localSelection: selection )
                .ignoresSafeArea(edges: .bottom)
        }
        .onPreferenceChange(TabBarItemsPreferenceKey.self, perform: { value in
            self.tabs = value
        })
    }
}
struct CustomTabBarContainterView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarContainterView(selection: .constant(.map)) { MainMapView() }
    }
}
