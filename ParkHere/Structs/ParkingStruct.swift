//
//  ParkingStruct.swift
//  ParkHere
//
//  Created by Jakub Prus on 16/03/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

// the following data is fetched from firestore
struct ParkingStruct: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var description: String
    var location: GeoPoint
    var level: String
    var quantity: Int
    var address: String
    var cost: Double
    var guarded: Bool
    
    static let sampleParking = ParkingStruct(id: "ABCD1234", name: "Parking Sample", description: "This is a sample description provided for this parking lot. It is suggested to not take it seriously.", location: GeoPoint(latitude: 52.23, longitude: 21.0), level: "C", quantity: 20, address: "Happy Street, Warsaw", cost: 9.99, guarded: true)
}


// GeoPoint is a built-in data type from FirebaseFirestore module
// Example use case:
// CLLocationCoordinate2D(latitude: ParkingStruct.location.latitude, longitude: ParkingStruct.location.longitude)
