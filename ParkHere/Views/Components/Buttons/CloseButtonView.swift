//
//  CloseButtonView.swift
//  ParkHere
//
//  Created by jabko on 28/03/2023.
//

import SwiftUI

struct CloseButtonView: View {
    @Environment(\.dismiss) var dismiss
    
    let image: String
    let alignment: Alignment

    internal init(image: String = "chevron.left", alignment: Alignment = .leading) {
        self.image = image
        self.alignment = alignment
    }
    
  
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: image)
                .foregroundColor(.customGrey)
                .font(.title3.weight(.semibold))
                .frame(maxWidth: .infinity, alignment: alignment)
        }
        
    }
}
struct CloseButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CloseButtonView()
    }
}
