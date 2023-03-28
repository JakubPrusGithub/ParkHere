//
//  TicketGenerationView.swift
//  ParkHere
//
//  Created by Jakub Prus on 27/03/2023.
//

import SwiftUI

struct TicketGenerationView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject var qrcode = QRgenerator()
    var ticket: ParkingTicket
    
    var body: some View {
        NavigationStack{
            VStack(){
                
                // MARK: QR Code
                VStack{
                    Text("That's your ticket:")
                        .font(.title)
                        .foregroundColor(.customGrey)
                        .padding(.bottom, -5)
                    Image(uiImage: qrcode.generateQRCode(ticket: ticket))
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                    Text(qrcode.hashedTicketString)
                        .foregroundColor(.customGrey)
                        .font(.caption2)
                        .frame(height: 70)
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
                
                // MARK: Dismiss
                VStack{
                    NavigationLink("OK"){
                        //back to ticket view
                    }
                    .buttonStyle(.sign)
                    .padding(.vertical)
                }
            }
            .padding()
            .navigationTitle("Thank you!")
        }
    }
}

struct TicketGenerationView_Previews: PreviewProvider {
    static var previews: some View {
        TicketGenerationView(ticket: .sampleTicket)
    }
}
