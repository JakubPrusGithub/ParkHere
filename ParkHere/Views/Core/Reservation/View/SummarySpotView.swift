//
//  SummaryView.swift
//  ParkHere
//
//  Created by Jakub Prus on 26/03/2023.
//

import SwiftUI

struct SummaryView: View {
    let summaryTicket: ParkingTicket
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // MARK: Parking Details
            parkingDetails
            
            // MARK: Personal Details
            personalDetails
            
            // MARK: Reservation details
            reservationDetails
            
            // MARK: Total
            total
            
            Spacer()
            
        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationView(parking: .sampleParking)
    }
}



extension SummaryView {
    
    private var parkingDetails: some View {
        Group{
            Text("Parking Details")
                .reservationTitle()
                .padding(.top)
            Text(summaryTicket.parkingName)
                .font(.title3.bold())
            Text(summaryTicket.address)
                .padding(.vertical, -10)
            
            Divider()
        }
        .foregroundColor(.customGrey)
    }
    
    private var personalDetails: some View {
        Group{
            Text("Personal Details")
                .reservationTitle()
                .padding(.top)
            Text(summaryTicket.name)
                .font(.title3)
                .bold()
            Text("License number: " + summaryTicket.licenseNumber)
                .padding(.vertical, -10)
            
            Divider()
        }
        .foregroundColor(.customGrey)
    }
    
    private var reservationDetails: some View {
        Group{
            Text("Reservation Details")
                .reservationTitle()
                .padding(.top)
            Text("Spot: " + summaryTicket.spotNumber)
                .font(.title3)
                .bold()
            Text(summaryTicket.startDate.formatted() + " - " + summaryTicket.endDate.formatted())
                .padding(.vertical, -10)
            
            Divider()
        }
        .foregroundColor(.customGrey)
    }
    
    private var total: some View {
        Group{
            HStack{
                Text("Total:")
                    .font(.title)
                Spacer()
                Text("$" + summaryTicket.price.description)
                    .font(.title.bold())
            }
            .padding(.top)
        }
        .foregroundColor(.customGrey)
    }
    
}
