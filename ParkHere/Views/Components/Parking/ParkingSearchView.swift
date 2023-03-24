//
//  ParkingSearchView.swift
//  ParkHere
//
//  Created by jabko on 16/03/2023.
//

import SwiftUI

struct ParkingSearchView: View {
    let parking: Parking
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("clock")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 30, maxHeight: 30)
                    .padding(.horizontal)
                
                
                VStack(alignment: .leading) {
                    Text(parking.name)
                        .font(.callout)
                        .fontWeight(.semibold)
                    
                    
                    HStack {
                        Text(parking.street + " " + parking.number + ",")
                            .fixedSize(horizontal: true, vertical: false)
                        Text(parking.city)
                    }
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                     
                }
                
            }
        
            
            Divider()
        }
        .frame(maxWidth: .infinity)
        
    }
}

struct ParkingSearchView_Previews: PreviewProvider {
    static var previews: some View {
//        ParkingSearchView(parking: Parking.sampleParking)
        ConceptMainView(selectedTab: .constant(.map))
    }
}
