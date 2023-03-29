//
//  TicketListener.swift
//  ParkHere
//
//  Created by Jakub Prus on 28/03/2023.
//

import Foundation
import Firebase

class TicketListener: ObservableObject {
    
    let db = Firestore.firestore()
    @Published var newTicket = ParkingTicket.sampleTicket
    
    init(){
        let listener = db.collection("ticket").addSnapshotListener { (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            snapshot.documentChanges.forEach { diff in
                if (diff.type == .added) {
                    do{
                        self.newTicket = try diff.document.data(as: ParkingTicket.self)
                        print("New data: \(self.newTicket)")
                    }
                    catch{
                        print("Failed to decode new ticket: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}
