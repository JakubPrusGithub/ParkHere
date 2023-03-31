//
//  ParkingSerivce.swift
//  ParkHere
//
//  Created by jabko on 30/03/2023.
//

import Foundation
import Firebase
import FirebaseFirestore


protocol ParkingServiceProtocol {
    func fetchParkings() async throws -> [ParkingStruct]
}



class ParkingService: ParkingServiceProtocol {
    private let fm = FirebaseManager()

    @MainActor
    func fetchParkings() async throws -> [ParkingStruct] {
        try await fm.fetchCollecion(collection: "parking")
    }
    
}



class MockParkingService: ParkingServiceProtocol {
    
    func fetchParkings() -> [ParkingStruct] {
        let parkings: [ParkingStruct] = [
            ParkingStruct(id: "ABCD1234", name: "Parking Sample 1", description: "This is a sample description provided for this parking lot. It is suggested to not take it seriously.", location: GeoPoint(latitude: 52.23, longitude: 21.0), level: "D", quantity: 20, address: "Happy Street, Warsaw", cost: 9.99, guarded: true),
            
            ParkingStruct(id: "AAAA", name: "Parking Sample - 2", description: "This is a sample description provided for this parking lot. It is suggested to not take it seriously.", location: GeoPoint(latitude: 54.23, longitude: 22.0), level: "C", quantity: 30, address: "Sad Street, Warsaw", cost: 10, guarded: false )
        ]
        return parkings
    }
    
}


