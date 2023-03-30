//
//  ForgotPasswordView.swift
//  ParkHere
//
//  Created by jabko on 28/03/2023.
//

import SwiftUI

struct ForgotPasswordView: View {
    @ObservedObject var vm: LoginViewVM
    @State private var errorMessage: String = ""
    @State private var showMessage: Bool = false
    
    var body: some View {
        VStack {
            CloseButtonView()

            Spacer()
            
            VStack {
                LogoView()
                
                Text(errorMessage)
                    .font(.footnote)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .lineLimit(2, reservesSpace: true)
                    .frame(minHeight: 45)
                
                CustomTextField(text: $vm.email, placeholder: "enter you email", keyboardType: .emailAddress)
                
                Button("Send Reset Password") {
                    Task {
                        do {
                            try await vm.resetPassword()
                        } catch {
                            showMessage = true
                            errorMessage = error.localizedDescription
                        }
                       
                    }
                }
                    .buttonStyle(.sign)
            }
            
            Spacer()
            Spacer()

        }
        .padding()
        .padding(.horizontal)
    }
}
