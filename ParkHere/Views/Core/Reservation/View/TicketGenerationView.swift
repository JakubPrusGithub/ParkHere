//
//  TicketGenerationView.swift
//  ParkHere
//
//  Created by Jakub Prus on 27/03/2023.
//

import SwiftUI

struct TicketGenerationView: View {
    
    @StateObject var qrcode = QRgenerator()
    @EnvironmentObject var vm: ReservationViewModel
    var ticket: ParkingTicket
    
    var body: some View {
        VStack(){
            
            Text("Thank you!")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.customGrey)
                .padding()
            
            // MARK: QR Code
            VStack{
                Text("Here is your ticket:")
                    .font(.title)
                    .foregroundColor(.customGrey)
                    .padding(.bottom, -5)
                Image(uiImage: qrcode.generateQRCode(ticket: ticket))
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
            
            // MARK: Info
            HStack{
                Image(systemName: "info.circle")
                    .font(.title3)
                Text("Your ticket is available on your profile under the 'Tickets' tab.")
                    .font(.title3)
            }
            .padding(.top, 50)
            .foregroundColor(.gray)
            
            Spacer()
        }
        .padding()
        .onAppear{
            Task{
                await vm.addNewTicket(ticket: ticket)
            }
        }
    }
}

struct TicketGenerationView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationView(parking: .sampleParking)
            .environmentObject(ReservationViewModel())
    }
}
