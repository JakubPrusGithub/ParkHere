//
//  RegisterView.swift
//  ParkHere
//
//  Created by Michał Jabłoński on 11/03/2023.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var auth: AuthManager
    @StateObject private var vm = RegisterViewVM()
    init() { _ = Dependencies() }
    
    @State private var showMessege: Bool = false
    @State private var showBrands: Bool = false
    @State private var currentScreen: Int = 1
    
    
    var lastScreen: Bool { currentScreen == 2 }
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                // MARK: Top Bar
                headerRegister
                
                // MARK: Validate registration message
                message
                
                // MARK: Display current screen
                displayCurrentScreen
                
                if currentScreen == 1 { Spacer() }
               
                // MARK: Button
                navigationButton
               
                Spacer()
                
            }
            .padding()
            .padding(.horizontal)
            
            // MARK: Car brand picker
            Color.gray.ignoresSafeArea()
                .opacity(showBrands ? 0.3 : 0)
                .onTapGesture { showBrands = false }
                
                RoundedRectangle(cornerRadius: 50)
                    .edgesIgnoringSafeArea(.bottom)
                    .frame(maxHeight: 300)
                    .foregroundColor(.white)
                    .overlay {
                        CarBrandsView(brand: $vm.brand)
                    }
                    .opacity(showBrands ? 1 : 0 )
            
        }
        .frame(maxHeight: .infinity)
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}



extension RegisterView {
    
    private var headerRegister: some View {
        VStack  {
            Image(systemName: "chevron.left")
                .font(.title3.weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture {
                    if currentScreen == 1 { dismiss() }
                    else { currentScreen -= 1 }
                }
            
            LogoView()
        }
    }
    
    private var message: some View {
        Text(vm.validationMessage)
            .font(.footnote)
            .foregroundColor(.red)
            .multilineTextAlignment(.center)
            .lineLimit(2, reservesSpace: true)
            .frame(minHeight: 45)
            .opacity(showMessege ? 1 : 0)
    }
    
    private var navigationButton: some View {
        Button(lastScreen ? "Sign up" : "Next") {
            if lastScreen { isValidCarNumber() }
            else { isValid() }
        }
        .buttonStyle(.sign)
    }
    
    private var displayCurrentScreen: some View {
        VStack {
            switch currentScreen {
            case 1 : screenOne
            case 2 : screenTwo
            default : Text("Default")
            }
        }
    }
    
    private var screenOne: some View {
        VStack {
            CustomTextField(text: $vm.name,
                               placeholder: "first name",
                               keyboardType: .namePhonePad)
           
            CustomTextField(text: $vm.surname,
                               placeholder: "last name",
                               keyboardType: .namePhonePad)
            
            CustomTextField(text: $vm.email,
                               placeholder: "email@example.com",
                               keyboardType: .emailAddress)
            
            CustomSecureField(text: $vm.password,
                                 placeholder: "password")
            
            
            CustomSecureField(text: $vm.confirmPassword,
                                 placeholder: "confirm password")
            
        }
    }
    
    private var screenTwo: some View {
        VStack {
            HStack {
                Text(vm.brand.rawValue)
                
                Spacer()
                
                Image(vm.brand.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 40, maxHeight: 20)
                
            }
            .fieldBackground()
            .onTapGesture { showBrands.toggle() }
            
            CustomTextField(text: $vm.carNumber, placeholder: "KR 8PU64")
            
        }
    }
    
    
    // MARK: Functions
    func isValid() {
        if vm.validateRegistration().1 {
            showMessege = false
            currentScreen += 1
        } else {
            showMessege = true
            vm.validationMessage = vm.validateRegistration().0
        }
    }
    
    func isValidCarNumber() {
        if vm.validateCarNumber().1 {
            showMessege = false
            Task { try await vm.signUp() }
        } else {
            showMessege = true
            vm.validationMessage = vm.validateCarNumber().0
        }
            
    }
    
}
