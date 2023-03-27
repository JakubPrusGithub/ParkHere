//
//  ParkingFirestoreManager.swift
//  ParkHere
//
//  Created by Jakub Prus on 17/03/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseCore

@MainActor
class ParkingFirestoreManager: ObservableObject {
    
    let db = Firestore.firestore()
    @Published var firestoreParkings = [ParkingStruct]()
    
    init(){
        let collection = db.collection("parking")
        collection.getDocuments { querySnapshot, err in
            guard let results = querySnapshot else { return print("Error getting documents: \(err!.localizedDescription)")}
            
            for result in results.documents{
                do {
                    let parking = try result.data(as: ParkingStruct.self)
                    self.firestoreParkings.append(parking)
                }
                catch{
                    print("Failed to decode: \(error.localizedDescription)")
                }
            }
        }
    }
    
}
