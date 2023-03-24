//
//  ParkingDetailsView.swift
//  ParkHere
//
//  Created by Jakub Prus on 20/03/2023.
//

import SwiftUI

struct ParkingDetailsView: View {
    
    let parking: ParkingStruct
    
    var body: some View {
        Text(parking.name)
    }
}

struct ParkingDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ParkingDetailsView(parking: ParkingStruct.sampleParking)
    }
}
