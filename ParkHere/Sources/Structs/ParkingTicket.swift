//
//  ParkingTicket.swift
//  ParkHere
//
//  Created by Jakub Prus on 26/03/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct ParkingTicket: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    let name: String
    let licenseNumber: String
    let parkingName: String
    let address: String
    let spotNumber: String
    let startDate: Date
    let endDate: Date
    let price: Double
}
