//
//  TicketFullView.swift
//  ParkHere
//
//  Created by Jakub Prus on 31/03/2023.
//

import SwiftUI

struct TicketFullView: View {
    
    @Environment(\.dismiss) private var dismiss
    let ticket: ParkingTicket
    @StateObject var qrcode = QRgenerator()
    @State var cancel = false
    let future: Bool
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(alignment: .leading, spacing: 10){
                    
                    // MARK: QR Code
                    Image(uiImage: qrcode.generateQRCode(ticket: ticket))
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 350, height: 350)
                    
                    // MARK: Reservation Details
                    Text("Reservation Details")
                        .font(.title)
                        .foregroundColor(.gray)
                    Group{
                        Text("Address: " + ticket.address)
                        Text("Start time: " + ticket.startDate.formatted())
                        Text("End time: " + ticket.endDate.formatted())
                        Text("Spot: " + ticket.spotNumber)
                        Text("Vehicle registration number: " + ticket.licenseNumber)
                        Text("Cost: $" + ticket.price.description)
                    }
                    .font(.title3)
                    
                    Spacer()
                }
            }
            .navigationTitle(ticket.parkingName)
            .toolbar{
                if future {
                    Button("Cancel reservation"){
                        cancel = true
                    }
                    .foregroundColor(.red)
                }
            }
            .alert("Are you sure you want to delete the reservation?", isPresented: $cancel) {
                Button("Delete", role: .destructive) {
                    dismiss()
                    //delete
                }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
}

struct TicketFullView_Previews: PreviewProvider {
    static var previews: some View {
        TicketFullView(ticket: .sampleTicket, future: true)
    }
}
