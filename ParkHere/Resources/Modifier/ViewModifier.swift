//
//  ViewModifier.swift
//  ParkHere
//
//  Created by jabko on 28/03/2023.
//

import Foundation
import SwiftUI


extension View {
    // #1
    func fieldBackground() -> some View {
        modifier(FieldViewModifier())
    }
    
    // #2
    func customBackground(type: CustomBackgroundModifier.ColorType) -> some View {
        modifier(CustomBackgroundModifier(type: type))
    }
    
    // #3
    func tabBarItem(tab: TabBarItem, selection: Binding<TabBarItem>) -> some View {
        modifier(TabBarItemViewModifier(tab: tab, selection: selection))
    }
    
    //4
    func shadowBorderBackground() -> some View {
        modifier(ShadowBorderBackgroundModifier())
    }
}

// MARK: #1
struct FieldViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .background(
                Color.white
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 6, x: 0, y: 2)
                    .blur(radius: 10)
            )
    }
}

// MARK: #2
struct CustomBackgroundModifier: ViewModifier {
    enum ColorType { case light, dark }
    var type: ColorType
    
    private var color: (foregroundColor: Color, backgroundColor: Color) {
        switch type {
        case .light: return (Color.secondary, Color.white)
        case .dark: return (Color.white, Color.customGrey)
        }
    }
    
    func body(content: Content) -> some View {
        content
            .fontWeight(.semibold)
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(color.foregroundColor)
            .background(color.backgroundColor)
            .cornerRadius(10)
            .shadow(radius: 1)
        
    }
}

// MARK: #3
struct TabBarItemViewModifier: ViewModifier {
    let tab: TabBarItem
    @Binding var selection: TabBarItem
    func body(content: Content) -> some View {
        content
            .opacity(selection == tab ? 1.0 : 0)
            .preference(key: TabBarItemsPreferenceKey.self, value: [tab])
    }
}

// MARK: #4
struct ShadowBorderBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .fontWeight(.semibold)
            .background(.white)
            .cornerRadius(20)
            .shadow(radius: 1)
    }
}
