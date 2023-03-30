//
//  Button+ButtonStyle.swift
//  ParkHere
//
//  Created by Michał Jabłoński on 11/03/2023.
//

import Foundation
import SwiftUI


struct SignButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color.customGrey)
            .cornerRadius(10)
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

extension ButtonStyle where Self == SignButtonStyle {
    static var sign: Self {
        return .init()
    }
}

