//
//  RegisterView.swift
//  ParkHere
//
//  Created by Michał Jabłoński on 11/03/2023.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var auth: AuthMaganer
    
    @State private var showPassword: Bool = false
    var body: some View {
        VStack {
            // MARK: Logo
            LogoView()
            
            
            // MARK: Text Fields
            VStack {
                TextField("first name", text: $auth.name)
                    .modifier(TextFieldModifier(text: $auth.name))
                
                
                TextField("last name", text: $auth.lastName)
                    .modifier(TextFieldModifier(text: $auth.lastName))
                
                
                TextField("email@example.com", text: $auth.email)
                    .modifier(TextFieldModifier(text: $auth.email))
                
                
                SecureField("password", text: $auth.password)
                    .modifier(SecureFieldModifier(text: $auth.password,
                                                  bool: $showPassword,
                                                  title: "password"))
                
                SecureField("confirm password", text: $auth.confirmPasswrod)
                    .modifier(SecureFieldModifier(text: $auth.password,
                                                  bool: $showPassword,
                                                  title: "confirm password"))
            }
           
            
            Spacer()
            
        }
        .padding()
        .padding(.horizontal)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .environmentObject(AuthMaganer())
    }
}
