//
//  LoginView.swift
//  ParkHere
//
//  Created by jabko on 12/03/2023.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var vm = LoginViewVM()
    init() { _ = Dependencies() }
    
    @State private var showForgotPassword: Bool = false
    @State private var errorMessage: String = ""
    @State private var attempts: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                // MARK: Button + Logo
                loginHeader

                Spacer()
                
                // MARK: Error Message
                message
                
                // MARK: TextFields
                textFields

                // MARK: Forgot + Login
                manageButtons

                Spacer()
                Spacer()

                // MARK: OR + Rectangles
                orSignWith

                // MARK: Auth buttons
                authButtons

                // MARK: NavigationLink -> RegisterView
               registerView
                
            }
            .padding()
            .padding(.horizontal)
            .toolbar(.hidden, for: .navigationBar)
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .modifier(Shake(animatableData: CGFloat(attempts)))
            .sheet(isPresented: $showForgotPassword) {
                ForgotPasswordView(vm: vm)
            }
            .environmentObject(LoginViewVM())
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


extension LoginView {
    
    private var loginHeader: some View {
        VStack {
            CloseButtonView()

            LogoView()
        }
    }
    
    private var message: some View {
        Text(errorMessage)
            .font(.footnote)
            .foregroundColor(.red)
            .multilineTextAlignment(.center)
            .lineLimit(2, reservesSpace: true)
            .frame(minHeight: 45)
        
    }
    
    private var textFields: some View {
        VStack {
            CustomTextField(text: $vm.email,
                               placeholder: "email@example.com",
                               keyboardType: .emailAddress)

            CustomSecureField(text: $vm.password,
                                 placeholder: "password")
        }
    }
    
    private var manageButtons: some View {
        VStack {
            Text("forgot password?")
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.vertical)
                .onTapGesture { showForgotPassword.toggle() }
            
            Button("Login") {
                Task {
                    do {
                        try await vm.signIn()
                        
                    } catch {
                        errorMessage = error.localizedDescription
                        withAnimation { self.attempts += 1 }
                    }
                }
            }
            .buttonStyle(.sign)
            
        }
    }
    
    private var orSignWith: some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]),
                                   startPoint: .leading,
                                   endPoint: .trailing))
                .frame(maxWidth: .infinity, maxHeight: 1)
                
            Text("OR")
                
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]),
                                   startPoint: .trailing,
                                   endPoint: .leading))
                .frame(maxWidth: .infinity, maxHeight: 1)
                
        }
        .padding(.bottom)
    }
    
    private var authButtons: some View {
        HStack {
            AuthButtonView(type: .google)
            
            AuthButtonView(type: .facebook)
            
            AuthButtonView(type: .apple)
            
        }
        .padding(.bottom)
    }
    
    private var registerView: some View {
        NavigationLink { RegisterView() }
        label: {
            Text("Don't have an account?")
                .foregroundColor(.secondary)
            Text("Sign up")
                .foregroundColor(.black)
        }
    }
    
}

