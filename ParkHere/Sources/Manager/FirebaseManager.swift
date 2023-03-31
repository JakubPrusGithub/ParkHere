//
//  FirebaseManager.swift
//  ParkHere
//
//  Created by jabko on 30/03/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirebaseManager {
    let db = Firestore.firestore()
    
}


// MARK: Fetch
extension FirebaseManager {
    @MainActor
    func fetchCollecion<T: Codable>(collection: String) async throws -> [T] {
        do {
            let snapshot = try await db.collection(collection).getDocuments()
            
            return try snapshot.documents.compactMap { doc in
                try doc.data(as: T.self)
            }
        } catch {
            throw URLError(.badServerResponse)
        }
        
    }
}

// MARK: New ticket
extension FirebaseManager {
    @MainActor
    func sendNewTicket(ticket: ParkingTicket){
        do {
            try db.collection("ticket").document(ticket.id!).setData(from: ticket)
        } catch let error {
            print("Error while adding new ticket: \(error)")
        }
    }
}

// MARK: Check if outdated ticket
extension FirebaseManager {
    @MainActor
    func checkIfOutdated(ticket: ParkingTicket){
        guard Date.now > ticket.endDate else { return }
        let ticketRef = db.collection("ticket").document(ticket.id!)
        ticketRef.delete() { error in
            if let error = error {
                print("Error while deleting outdated ticket: \(error)")
            }
            else {
                print("Deletion completed")
            }
        }
    }
}
