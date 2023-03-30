//
//  CustomTextField.swift
//  ParkHere
//
//  Created by jabko on 28/03/2023.
//

import Foundation
import SwiftUI


struct CustomTextField: View {
   
    @Binding var text: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    
    init(text: Binding<String>, placeholder: String, keyboardType: UIKeyboardType = .default) {
        self._text = text
        self.placeholder = placeholder
        self.keyboardType = keyboardType
    }
    
    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .textInputAutocapitalization(.never)
                .keyboardType(keyboardType)
                
            Image(systemName: "xmark.circle")
                .frame(maxWidth: 30, alignment: .center)
                .onTapGesture { text = "" }
                .opacity(text.isEmpty ? 0 : 1)
                
        }
        .fieldBackground()
    }
}
