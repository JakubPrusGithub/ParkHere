//
//  ParkingStruct.swift
//  ParkHere
//
//  Created by Jakub Prus on 16/03/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct ParkingStruct: Codable {
    @DocumentID var id: String?
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    var level: String
    var quantity: Int
    var address: String
    var cost: Double
    var guarded: Bool
}
