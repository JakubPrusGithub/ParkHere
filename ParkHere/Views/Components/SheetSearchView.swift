//
//  SheetSearchView.swift
//  ParkHere
//
//  Created by Jakub Prus on 16/03/2023.
//

import SwiftUI

struct SheetSearchView: View {
    
    @State private var text = ""
    @State private var isEditing = false
    
    var body: some View {
        NavigationStack{
        }
        .searchable(text: $text, prompt: "Search parkings...")
        .offset(y: -30)
        
    }
}

struct SheetSearchView_Previews: PreviewProvider {
    static var previews: some View {
        SheetSearchView()
    }
}
