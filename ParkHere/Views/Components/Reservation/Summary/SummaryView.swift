//
//  SummaryView.swift
//  ParkHere
//
//  Created by Jakub Prus on 26/03/2023.
//

import SwiftUI

struct SummaryView: View {
    
    @Environment(\.dismiss) private var dismiss
    let summaryTicket: ParkingTicket
    @ObservedObject var resVM: ReservationSpotViewModel
    @StateObject var ticketListener = TicketListener()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                
                // MARK: Parking Details
                Group{
                    Text("Parking Details")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding(.top)
                    Text(summaryTicket.parkingName)
                        .font(.title3)
                        .bold()
                    Text(summaryTicket.address)
                        .padding(.vertical, -10)
                    
                    Divider()
                }
                .foregroundColor(.customGrey)
                
                // MARK: Parking Details
                Group{
                    Text("Personal Details")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding(.top)
                    Text(summaryTicket.name)
                        .font(.title3)
                        .bold()
                    Text("License number: " + summaryTicket.licenseNumber)
                        .padding(.vertical, -10)
                    
                    Divider()
                }
                .foregroundColor(.customGrey)
                
                // MARK: Reservation details
                Group{
                    Text("Reservation Details")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding(.top)
                    Text("Spot: " + summaryTicket.spotNumber)
                        .font(.title3)
                        .bold()
                    Text(summaryTicket.startDate.formatted() + " - " + summaryTicket.endDate.formatted())
                        .padding(.vertical, -10)
                    
                    Divider()
                }
                .foregroundColor(.customGrey)
                
                // MARK: Total
                Group{
                    HStack{
                        Text("Total:")
                            .font(.title)
                        Spacer()
                        Text("$" + summaryTicket.price.description)
                            .font(.title)
                            .bold()
                    }
                    .padding(.top)
                }
                .foregroundColor(.customGrey)
                
                Spacer()
                
                // MARK: Checkout
                VStack{
                    NavigationLink("Checkout"){
                        TicketGenerationView(ticket: summaryTicket)
                    }
                    .buttonStyle(.sign)
                    .padding(.vertical)
                    .disabled(!resVM.freeSpot)
                    Button("Cancel"){
                        dismiss()
                    }
                    .foregroundColor(.gray)
                    .padding(.top, -10)
                }
            }
            .navigationTitle("Summary")
            .padding()
            .onChange(of: ticketListener.newTicket) { _ in
                resVM.checkSummary(ticket: ticketListener.newTicket)
            }
        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView(summaryTicket: .sampleTicket, resVM: ReservationSpotViewModel(reservedTickets: [ParkingTicket.sampleTicket], allTickets: [ParkingTicket.sampleTicket], myStartDate: Date.now, myEndDate: Date.now, parking: .sampleParking, cost: 0.0))
    }
}
