//
//  SearchBarView.swift
//  ParkHere
//
//  Created by Jakub Prus on 18/03/2023.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchTerm: String
    @FocusState var isFocused: Bool
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            Image(isSearching ? "left" : "search")
                .flatIconImage()
                .onTapGesture {
                    isSearching = false
                    isFocused = false
                    if !isSearching { searchTerm = "" }
                }
            
            
            TextField("Search location", text: $searchTerm)
                .focused($isFocused)
                .onChange(of: isFocused) { _ in
                    isSearching = isFocused
                }
               
            
            Image("filter")
                .flatIconImage()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .fontWeight(.semibold)
        .background(.white)
        .cornerRadius(20)
        .shadow(radius: 1)
        .onChange(of: isSearching) { _ in
            isFocused = isSearching
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    @State static var searchTerm = ""
    @State static var isSearching = false
    static var previews: some View {
//        SearchBarView(searchTerm: $searchTerm, isSearching: $isSearching)
        MainMapView(selectedTab: .constant(.map))
    }
}
