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
    
    var body: some View {
        NavigationStack{
            VStack(){
                
                // MARK: QR Code
                VStack{
                    Image(uiImage: qrcode.generateQRCode(from: "ASD"))
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                    Text("QRCODE")
                        .font(.title)
                        .foregroundColor(.customGrey)
                        .bold()
                }
                .padding(.top, 30)
                
                // MARK: info
                Text("Your ticket is available on your profile under the 'Tickets' tab.\n\nScan your ticket by QR code or enter the code below it.")
                    .padding(.top, 30)
                    .foregroundColor(.customGrey)
                    .font(.title3)
                
                Spacer()
                
                // MARK: Dismiss
                VStack{
                    NavigationLink("OK"){
                        //generating qr code and ticket
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
        TicketGenerationView()
    }
}
