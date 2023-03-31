//
//  ReservatationService.swift
//  ParkHere
//
//  Created by jabko on 30/03/2023.
//

import Foundation


protocol ReservationServiceProtocol {
    func fetchTickets() async throws -> [ParkingTicket]
    func addNewTicket(ticket: ParkingTicket) async
    func checkIfOutdated(ticket: ParkingTicket)
}


class ReservationService: ReservationServiceProtocol {
    private let fm = FirebaseManager()
    
    @MainActor
    func fetchTickets() async throws -> [ParkingTicket] {
        try await fm.fetchCollecion(collection: "ticket")
    }
    
    @MainActor
    func addNewTicket(ticket: ParkingTicket) async {
        await fm.sendNewTicket(ticket: ticket)
    }
    
    @MainActor
    func checkIfOutdated(ticket: ParkingTicket) {
        fm.checkIfOutdated(ticket: ticket)
    }
}
