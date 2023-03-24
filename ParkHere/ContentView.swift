//
//  ContentView.swift
//  ParkHere
//
//  Created by Jakub Prus on 06/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var searchbarText = ""
    
    var body: some View {
        NavigationView{
            ScrollView{
                ForEach(1..<10) { parking in
                    Rectangle()
                        .foregroundColor(.blue)
                        .frame(width: 350, height: 200)
                        .frame(maxWidth: .infinity)
                        .padding(5)
                    //dev to main
                }
                .searchable(text: $searchbarText)
            }
            .navigationTitle("Find your parking lot")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
