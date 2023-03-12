//
//  View+ViewModifier.swift
//  ParkHere
//
//  Created by Michał Jabłoński on 11/03/2023.
//

import Foundation
import SwiftUI



extension View {
    func customHStackTextField() -> some View {
        modifier(CustomHStackModifier())
    }
}


// MARK: Text Fields
struct TextFieldModifier: ViewModifier {
    @Binding var text: String
    func body(content: Content) -> some View {
        HStack {
            content
                
            Image(systemName: "xmark.circle")
                .frame(maxWidth: 30, alignment: .center)
                .onTapGesture { text = "" }
                .opacity(text.isEmpty ? 0 : 1)
        }
        .customHStackTextField()
    }
}


struct SecureFieldModifier: ViewModifier {
    @Binding var text: String
    @Binding var bool: Bool
    
    let title: String
    
    func body(content: Content) -> some View {
        HStack {
            ZStack {
                TextField("password", text: $text)
                    .opacity(bool ? 1 : 0)
                
                content
                    .opacity(bool ? 0 : 1)
            }
            
            Image(systemName: bool ? "eye" : "eye.slash" )
                .onTapGesture { bool.toggle() }
        }
        .customHStackTextField()
    }
}


// MARK: Custom HStack
struct CustomHStackModifier: ViewModifier {
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


