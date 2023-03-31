//
//  ReservatationService.swift
//  ParkHere
//
//  Created by jabko on 30/03/2023.
//

import Foundation


protocol ReservationServiceProtocol {
    func fetchTickets() async throws -> [ParkingTicket]
}


class ReservationService: ReservationServiceProtocol {
    private let fm = FirebaseManager()

    @MainActor
    func fetchTickets() async throws -> [ParkingTicket] {
        try await fm.fetchCollecion(collection: "ticket")
    }

}
