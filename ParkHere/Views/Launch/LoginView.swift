//
//  LoginView.swift
//  ParkHere
//
//  Created by jabko on 12/03/2023.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var auth: AuthManager
    @Environment(\.dismiss) var dismiss
    @State private var showPassword: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
                // MARK: TopBar + Logo
                VStack {
                    Image(systemName: "chevron.left")
                        .font(.title3.weight(.semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .onTapGesture { dismiss() }
                    
                    LogoView()
                }
               
                
                Spacer()
                
                
                //MARK: TextFields
                VStack {
                    TextField("email@example.com", text: $auth.email)
                        .modifier(TextFieldModifier(text: $auth.email))
                    
                    SecureField("password", text: $auth.password)
                        .modifier(SecureFieldModifier(text: $auth.password,
                                                      bool: $showPassword,
                                                      title: "password"))
                }
                
                
                // MARK: Forgot + Login
                VStack {
                    Text("forgot password?")
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.vertical)
                    
                    Button("Login") { Task { await auth.singIn() } }
                        .buttonStyle(.sign)
                }
                
                
                Spacer()
                Spacer()
                
                
                // MARK: OR
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
                
                
                // MARK: Auth buttons
                HStack {
                    AuthButtonView(type: .google)
                    
                    AuthButtonView(type: .facebook)
                    
                    AuthButtonView(type: .apple)
                    
                }
                .padding(.bottom)
                
                
                NavigationLink { RegisterView() }
                label: {
                    Text("Don't have an account?")
                        .foregroundColor(.secondary)
                    Text("Sign up")
                        .foregroundColor(.black)
                }
             
                
            }
            .padding()
            .padding(.horizontal)
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthManager())
    }
}
