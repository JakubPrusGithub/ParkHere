//
//  TicketView.swift
//  ParkHere
//
//  Created by jabko on 17/03/2023.
//

import SwiftUI

struct TicketView: View {
    
    var body: some View {
        NavigationStack{
            List{
                Section("Future"){
                    NavigationLink(){
                        TicketFullView(ticket: .sampleTicket, future: true)
                    }label:{
                        TicketPreview(ticket: .sampleTicket, ended: true)
                    }
                }
                Section("Active"){
                    NavigationLink(){
                        TicketFullView(ticket: .sampleTicket, future: false)
                    }label:{
                        TicketPreview(ticket: .sampleTicket, ended: false)
                            .foregroundColor(.blue)
                    }
                }
                Section("History"){
                    NavigationLink(){
                        TicketFullView(ticket: .sampleTicket, future: false)
                    }label:{
                        TicketPreview(ticket: .sampleTicket, ended: true)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Tickets")
        }
    }
}

struct TicketView_Previews: PreviewProvider {
    static var previews: some View {
        TicketView()
    }
}
