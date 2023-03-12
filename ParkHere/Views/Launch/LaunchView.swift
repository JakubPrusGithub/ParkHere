//
//  LaunchView.swift
//  ParkHere
//
//  Created by Michał Jabłoński on 11/03/2023.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 120, maxHeight: 120)
            
            
            Text("Find your parking spot ")
                .font(.title)
                .fontWeight(.semibold)
                
            
            Image("city")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 400)
                .border(.red)
            
            Spacer()
            
           
        }
        .padding()
        .padding(.horizontal)
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
