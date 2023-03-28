//
//  ViewModifier.swift
//  ParkHere
//
//  Created by jabko on 28/03/2023.
//

import Foundation
import SwiftUI


extension View {
    func fieldBackground() -> some View {
        modifier(FieldViewModifier())
    }
    
    func customBackground(type: CustomBackgroundModifier.ColorType) -> some View {
        modifier(CustomBackgroundModifier(type: type))
    }
}


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
