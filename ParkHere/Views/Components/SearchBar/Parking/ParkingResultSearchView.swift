//
//  ParkingResultSearchView.swift
//  ParkHere
//
//  Created by Jakub Prus on 17/03/2023.
//

import SwiftUI

struct ParkingResultSearchView: View {
    let parking: ParkingModel
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "parkingsign.circle.fill")
                    .font(.title2)
                    .foregroundColor(.blue)
                    .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text(parking.name + "")
                        .font(.callout)
                        .fontWeight(.semibold)
                    
                    Text(parking.address + "")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: "greaterthan")
                    .padding(.horizontal, 25)
                
            }
            Divider()
        }
        
    }
}

struct ParkingSearchView_Previews: PreviewProvider {
    static var previews: some View {
        ParkingResultSearchView(parking: ParkingModel.sampleParking)
    }
}
