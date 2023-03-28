//
//  CustonNavLink.swift
//  ParkHere
//
//  Created by jabko on 28/03/2023.
//

import Foundation
import SwiftUI

struct CustomNavLink<Destination: View> : View {
    
    let destination: Destination
    let title: String
    let type: CustomBackgroundModifier.ColorType
    
    init(destination: Destination, title: String, type: CustomBackgroundModifier.ColorType = .light) {
        self.destination = destination
        self.title = title
        self.type = type
    }
    
    var body: some View {
        NavigationLink {
            destination
        } label: {
            Text(title)
                .customBackground(type: type)
        }

    }
}
