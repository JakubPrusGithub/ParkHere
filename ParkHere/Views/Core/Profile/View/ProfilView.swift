//
//  ProfilView.swift
//  ParkHere
//
//  Created by jabko on 17/03/2023.
//

import SwiftUI

struct ProfilView: View {
    @EnvironmentObject var auth: AuthManager
    @StateObject private var vm = ProfilViewModel()
    init() { _ = Dependencies() }
    
    @State private var showPaymentMethods = false
    @State private var showAbout = false
    
    var body: some View {
        NavigationStack {
            ZStack{
                VStack {
                    // MARK: Grey background
                    Rectangle()
                        .foregroundColor(.customGrey)
                        .ignoresSafeArea()
                        .frame(height: 250)
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 20){
                        
                        // MARK: Tickets
                        Button(){
                            //
                        }label:{
                            HStack{
                                Image(systemName: "ticket")
                                Text("Tickets")
                            }
                        }
                        .padding(.top, 50)
                        Divider()
                        
                        // MARK: Payment Methods
                        Button(){
                            showPaymentMethods = true
                        } label: {
                            HStack{
                                Image(systemName: "creditcard")
                                Text("Payment Methods")
                            }
                        }
                        .confirmationDialog("Select a payment method", isPresented: $showPaymentMethods, titleVisibility: .visible) {
                            Button("Apple Pay") { }
                            Button("Credit Card") { }
                            Button("Blik") { }
                        }
                        Divider()
                        
                        // MARK: About
                        Button(){
                            showAbout = true
                        }label:{
                            HStack{
                                Image(systemName: "info.circle")
                                Text("About")
                            }
                        }
                        .sheet(isPresented: $showAbout) {
                            VStack{
                                Text("ParkHere")
                                    .font(.title)
                                    .padding(.bottom)
                                Text("ParkHere is an app for reserving parking spots.\n\nWe made it for 'Zaprogramuj Życie' competition. \n\nAuthors: Jakub Prus & Michał Jabłoński. \n\nWe hope you enjoy using our app!")
                                Spacer()
                            }
                            .foregroundColor(.customGrey)
                            .padding(20)
                            .presentationDetents([.medium])
                        }
                        Divider()
                        
                        // MARK: Delete History
                        Button(){
                            //
                        }label:{
                            HStack{
                                Image(systemName: "trash")
                                Text("Delete History")
                            }
                        }
                        .foregroundColor(.red)
                        Divider()
                        
                        // MARK: Logout
                        Button() {
                            do {
                                try vm.singOut()
                                auth.logIn = false
                            } catch {
                                print(error.localizedDescription)
                            }
                        }label:{
                            HStack{
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                Text("Logout")
                            }
                        }
                        .foregroundColor(Color(red: 0.8, green: 0, blue: 0))
                    }
                    .padding(30)
                    .font(.title2)
                    Spacer()
                }
                
                VStack{
                    
                    // MARK: Profile Text
                    Text("Profile")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .padding()
                    ZStack{
                        
                        // MARK: Profile Card
                        Rectangle()
                            .frame(height: 230)
                            .foregroundColor(.white)
                            .cornerRadius(30)
                            .shadow(radius: 10)
                            .padding(.top)
                            .padding(.horizontal)
                        VStack{
                            Image(systemName: "person.crop.circle")
                                .font(.system(size: 125))
                                .padding(.bottom, 5)
                            Text("Imie Nazwisko")
                                .font(.title)
                            
                        }
                    }
                    Spacer()
                }
            }
            .foregroundColor(.customGrey)
        }
    }
}

struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilView()
    }
}
