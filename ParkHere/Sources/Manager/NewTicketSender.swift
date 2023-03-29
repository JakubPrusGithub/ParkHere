//
//  NewTicketSender.swift
//  ParkHere
//
//  Created by Jakub Prus on 28/03/2023.
//

import Foundation
import Firebase

@MainActor
class NewTicketSender: ObservableObject {
    
    let db = Firestore.firestore()
    
    func sendNewTicket(ticket: ParkingTicket, documentID: String){
        do {
            try db.collection("ticket").document(UUID().uuidString).setData(from: ticket)
        } catch let error {
            print("Error encoding person: \(error)")
        }
    }
}
