//
//  TicketDeletion.swift
//  ParkHere
//
//  Created by Jakub Prus on 01/04/2023.
//

import Foundation
import Firebase

class TicketDeletion: ObservableObject {
    
    let db = Firestore.firestore()
    
    @MainActor
    func deleteTicket(ticket: ParkingTicket){
        let ticketRef = db.collection("ticket").document(ticket.id!)
        ticketRef.delete() { error in
            if let error = error {
                print("Error while canceling ticket: \(error)")
            }
            else {
                print("Cancel completed")
            }
        }
    }
}
