//
//  AuthButtonView.swift
//  ParkHere
//
//  Created by Michał Jabłoński on 11/03/2023.
//

import SwiftUI

struct AuthButtonView: View {
    @EnvironmentObject var auth: AuthManager
    
    enum ButtonType { case facebook, google, apple }
    var type: ButtonType
    
    private var button: (image: String, action: () -> Void) {
        switch type {
        case .google: return ("google", { Task { await auth.loginWithGoogle () } } )
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

struct AuthButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AuthButtonView(type: .apple)
    }
}
