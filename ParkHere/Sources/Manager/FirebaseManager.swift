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

