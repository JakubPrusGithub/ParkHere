//
//  AuthButtonView.swift
//  ParkHere
//
//  Created by jabko on 28/03/2023.
//

import SwiftUI

struct AuthButtonView: View {
    @EnvironmentObject var vm: LoginViewVM
    
    enum ButtonType { case facebook, google, apple }
    var type: ButtonType
    
    private var button: (image: String, action: () -> Void) {
        switch type {
        case .google: return ("google", { Task { try await vm.singInGoogle() } } )
        case .facebook: return ("facebook", { } )
        case .apple: return ("apple", { } )
        }
    }
    
    var body: some View {
        Button {
            button.action()
        } label: {
            Image(button.image)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 25)
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

