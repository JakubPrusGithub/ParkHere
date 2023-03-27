//
//  RegisterView.swift
//  ParkHere
//
//  Created by Michał Jabłoński on 11/03/2023.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var auth: AuthManager
    @Environment(\.dismiss) var dismiss
    
    @State private var brand: CarBrand = CarBrand.Audi
    @State private var showBrands: Bool = false
    @State private var carNumber: String = ""
    
    @State private var currentScreen: Int = 1
    var lastScreen: Bool { currentScreen == 2 }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                
                // MARK: Top Bar
                Image(systemName: "chevron.left")
                    .font(.title3.weight(.semibold))
                    .onTapGesture {
                        if currentScreen == 1 { dismiss() }
                        else { currentScreen -= 1 }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                // MARK: Logo
                LogoView()
                
                VStack {
                    switch currentScreen {
                    case 1 : ScreenOne()
                    case 2 : ScreenTwo(brand: $brand, carNumber: $carNumber, showBrands: $showBrands)
                    default : Text("Default")
                    }
                }
                
                if currentScreen == 1 { Spacer() }
               
                
                
                Button(lastScreen ? "Register" : "Next") {
                    if currentScreen == 2 { Task { await auth.singUp() } }
                    else { currentScreen += 1 }
                }
                    .buttonStyle(.sign)
               
                
                Spacer()
                
            }
            .padding()
            .padding(.horizontal)
            
            Color.gray.ignoresSafeArea()
                .opacity(showBrands ? 0.3 : 0)
                .onTapGesture { showBrands = false }
                
                RoundedRectangle(cornerRadius: 50)
                    .edgesIgnoringSafeArea(.bottom)
                    .frame(maxHeight: 300)
                    .foregroundColor(.white)
                    .overlay {
                        ChooseBrand(brand: $brand)
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
            .environmentObject(AuthManager())
    }
}


struct ScreenOne: View {
    @EnvironmentObject var auth: AuthManager
    
    @State private var showPassword: Bool = false
    var body: some View {
        VStack {
           
            
            TextField("first name", text: $auth.name)
                .modifier(TextFieldModifier(text: $auth.name))
            
            
            TextField("last name", text: $auth.surname)
                .modifier(TextFieldModifier(text: $auth.surname))
            
            
            TextField("email@example.com", text: $auth.email)
                .modifier(TextFieldModifier(text: $auth.email))
            
            
            SecureField("password", text: $auth.password)
                .modifier(SecureFieldModifier(text: $auth.password,
                                              bool: $showPassword,
                                              title: "password"))
            
            SecureField("confirm password", text: $auth.confirmPassword)
                .modifier(SecureFieldModifier(text: $auth.password,
                                              bool: $showPassword,
                                              title: "confirm password"))
        }
     
    }
}

struct ScreenTwo: View {
    @Binding var brand: CarBrand
    @Binding var carNumber: String
    @Binding var showBrands: Bool
    var body: some View {
        VStack {
        
            VStack {
                   
                
                
                HStack {
                    Text(brand.rawValue)
                   
                    
                    Spacer()
                    
                    Image(brand.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 40, maxHeight: 20)
                        
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .background(
                    Color.white
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 6, x: 0, y: 2)
                        .blur(radius: 10)
                )
                .onTapGesture { showBrands.toggle() }
                
                
                TextField("KR 8PU64", text: $carNumber)
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
    }
}



struct ChooseBrand: View {
    @Binding var brand: CarBrand
    var body: some View {
        VStack {
            Text("Select the brand of the vehicle")
                .fontWeight(.semibold)
            Picker("", selection: $brand) {
                ForEach(CarBrand.allCases, id: \.self) { brand in
                    Text(brand.rawValue)
                }
            }
            .pickerStyle(.wheel)
        }
    }
}




enum CarBrand: String, CaseIterable {
    case AlfaRomeo = "Alfa Romeo"
    case Audi
    case Bentley, BMW
    case Citroën
    case Ferrari, Fiat, Ford
    case Honda, Hyundai
    case Jaguar, Jeep
    case Kia
    case Lamborghini, Lexus
    case Mazda, Mitsubishi
    case MercedesBenz = "Mercedes Bens"
    case Nissan
    case Opel
    case Peugeot, Polonez, Porsche, Renault
    case Seat, Skoda
    case Tesla, Toyota
    case Volkswagen, Volvo
}
