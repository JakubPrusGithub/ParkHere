//
//  ParkingResultSearchView.swift
//  ParkHere
//
//  Created by Jakub Prus on 17/03/2023.
//

import SwiftUI

struct ParkingResultSearchView: View {
    let parking: ParkingStruct
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "parkingsign.circle.fill")
                    .font(.title2)
                    .foregroundColor(.blue)
                    .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text(parking.name)
                        .font(.callout)
                        .fontWeight(.semibold)
                    
                    HStack {
                        Text(parking.address)
                    }
                    .font(.footnote)
                    .foregroundColor(.secondary)
                }
                .lineLimit(1)
                Spacer()
                Image(systemName: "greaterthan")
                    .padding(.horizontal, 25)
            }
            Divider()
        }
    }
}

struct ParkingSearchView_Previews: PreviewProvider {
    static var previews: some View {
        ParkingResultSearchView(parking: ParkingStruct.sampleParking)
    }
}
