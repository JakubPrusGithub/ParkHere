//
//  TicketPreview.swift
//  ParkHere
//
//  Created by Jakub Prus on 31/03/2023.
//

import SwiftUI

struct TicketPreview: View {
    
    let ticket: ParkingTicket
    let ended: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            Text(ticket.parkingName)
                .font(.title2)
                .bold()
            Text(ticket.address)
                .font(.caption)
                .foregroundColor(.gray)
            Text(ended ? "From: " + ticket.startDate.formatted() : "Ending at: " + ticket.endDate.formatted())
            Text("Spot: " + ticket.spotNumber)
        }
    }
}

struct TicketPreview_Previews: PreviewProvider {
    static var previews: some View {
        TicketPreview(ticket: .sampleTicket, ended: false)
    }
}
