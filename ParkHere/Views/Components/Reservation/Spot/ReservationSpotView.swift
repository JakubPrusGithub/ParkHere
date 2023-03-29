//
//  ReservationSpotView.swift
//  ParkHere
//
//  Created by Jakub Prus on 24/03/2023.
//

import SwiftUI

struct ReservationSpotView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject var reservationVM = ReservationSpotViewModel()
    @StateObject var ticketListener = TicketListener()
    let myStartDate: Date
    let myEndDate: Date
    let parking: ParkingStruct
    let cost: Double
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 25){
                Text("Please choose your spot")
                    .padding(.vertical, 30)
                    .font(.title2)
                    .foregroundColor(.gray)
                // MARK: Picker
                Picker("Please select your parking level", selection: $reservationVM.selectedLevel){
                    ForEach(reservationVM.levels, id: \.self){
                        Text($0)
                    }
                }
                .onChange(of: reservationVM.selectedLevel, perform: { newLetter in
                    reservationVM.checkReservations(letter: newLetter)
                })
                .pickerStyle(.segmented)
                Picker("Please select your parking number", selection: $reservationVM.selectedNumber){
                    ForEach(reservationVM.quantity, id: \.self){
                        Text($0.description)
                    }
                }
                .pickerStyle(.wheel)
                
                Spacer()
                
                // MARK: Continue
                VStack{
                    NavigationLink("Continue"){
                        SummaryView(summaryTicket: reservationVM.createTicket(), resVM: reservationVM)
                    }
                    .buttonStyle(.sign)
                    .padding(.vertical)
                    //.disabled(!ticketListener.emptySpot)
                    Button("Cancel"){
                        dismiss()
                    }
                    .foregroundColor(.gray)
                    .padding(.top, -10)
                }
            }
            .padding()
            .navigationTitle("Parking spot")
            .onAppear{
                reservationVM.startFetching(start: myStartDate, end: myEndDate, parking: parking, cost: cost)
            }
            .onChange(of: ticketListener.newTicket) { _ in
                reservationVM.fetchTickets()
            }
        }
    }
}

struct ReservationSpotView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationSpotView(myStartDate: Date(), myEndDate: Date(), parking: .sampleParking, cost: 0.0)
    }
}
