//
//  Image.swift
//  ParkHere
//
//  Created by jabko on 16/03/2023.
//

import Foundation
import SwiftUI


extension Image {
    func flatIconImage() -> some View {
        self
            .renderingMode(.template)
            .resizable()
            .frame(maxWidth: 20, maxHeight: 20)
    }
}
