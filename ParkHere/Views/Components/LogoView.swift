//
//  LogoView.swift
//  ParkHere
//
//  Created by Michał Jabłoński on 11/03/2023.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 120, maxHeight: 120)
            
            Text("Park Here")
                .font(.title)
                .fontWeight(.semibold)
        }
        
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
