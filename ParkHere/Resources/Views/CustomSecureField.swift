//
//  CustomSecureField.swift
//  ParkHere
//
//  Created by jabko on 28/03/2023.
//

import Foundation
import SwiftUI

struct CustomSecureField: View {
    
    @State private var showPassword: Bool = false
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        HStack {
            ZStack {
                TextField(placeholder, text: $text)
                    .opacity(showPassword ? 1 : 0)
                
                SecureField(placeholder, text: $text)
                    .opacity(showPassword ? 0 : 1)
            }
            .textContentType(.password)
            .textInputAutocapitalization(.never)
            
            Image(systemName: showPassword ? "eye" : "eye.slash" )
                .onTapGesture { showPassword.toggle() }
        }
        .fieldBackground()
    }
}
