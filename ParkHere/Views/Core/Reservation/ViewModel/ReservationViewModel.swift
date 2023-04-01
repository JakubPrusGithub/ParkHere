//
//  ReservationViewModel.swift
//  ParkHere
//
//  Created by jabko on 31/03/2023.
//

import Foundation

class ReservationViewModel: ObservableObject {
    @Inject var reseration: ReservationServiceProtocol
    @Inject var fm: FMServiceProtocol
    
    // --User
    @Published var user: UserModel = UserModel()
    
    // --Parking
    @Published var parking: ParkingStruct = .sampleParking
    @Published var reservedTickets: [ParkingTicket] = []
    var allTicket: [ParkingTicket] = []
    
    // --Calendar
    @Published var startDate: Date = Date().roundedToNearestQuarter()
    @Published var endDate: Date = Date().minParkingTime()
    @Published var cost: Double = 0.0
    
    // --ReservationSpot
    @Published var selectedLevel: String = "A"
    @Published var selectedSpot: Int = 1
    @Published var levels: [String] = []
    @Published var quantity: [Int] = []
    
//    // --User Data
//    @Published var name = "Imie Nazwisko"
//    @Published var licenseNumber = "AB 12345"
    
    @Published var newTicket = ParkingTicket.sampleTicket
    
    
    
    var occupied = false
    
    let calendar = Calendar.current
    
    init() {
        //Task { await ticketListener() }
        Task { try await fetchTickets() }
        user = fm.getUserInfo()
    }
}


// MARK: Functions -- Calendar
extension ReservationViewModel {
    // TODO: Return - Selected time
    func selectedTimeInnterval() -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .hour, .minute], from: startDate, to: endDate)
        
        var timeComponents: [String] = []
        
        if let days = components.day, days > 0 {
            timeComponents.append("\(days) \(days == 1 ? "day" : "days")")
        }
        
        if let hours = components.hour, hours > 0 {
            timeComponents.append("\(hours) \(hours == 1 ? "hour" : "hours")")
        }
        
        if let minutes = components.minute {
            timeComponents.append("\(minutes)" + " minutes")
        }
        
        return timeComponents.joined(separator: ", ")
    }
    
    
    // TODO: Return - Your estimated cost is:
    func calcCost(perHour: Double) -> (Double, String) {
        let component = calendar.dateComponents([.minute], from: startDate, to: endDate)
        var quarters: Double = 0
        
        if let minutes = component.minute {
            quarters = Double(minutes/15)
        }
        return (quarters, String(format: "%.2f", Double(quarters)*(perHour/4)))
    }
    
    func calcFinalCost(){
        let component = calendar.dateComponents([.minute], from: startDate, to: endDate)
        var quarters: Double = 0
        
        if let minutes = component.minute {
            quarters = Double(minutes/15)
        }
        self.cost = Double(String(format: "%.2f", Double(quarters)*(parking.cost/4))) ?? 0.0
    }
}


// MARK: Functions -- ReservationSpotView
extension ReservationViewModel {
    
    @MainActor
    func fetchTickets() async throws {
        self.allTicket = try await reseration.fetchTickets()
    }
    
    @MainActor
    func addNewTicket(ticket: ParkingTicket) async {
        await reseration.addNewTicket(ticket: ticket)
    }
    
    @MainActor
    func checkTicket() {
        for ticket in allTicket {
            self.checkIfColliding(ticket: ticket)
            self.checkReservations(letter: self.selectedLevel)
            reseration.checkIfOutdated(ticket: ticket)
        }
    }
    
    // Checks if ticket is colliding with user's reservation
    func checkIfColliding(ticket: ParkingTicket){
        if ticket.endDate <= endDate, ticket.endDate >= startDate {
            reservedTickets.append(ticket)
        }
        else if ticket.startDate <= endDate, ticket.startDate >= startDate{
            reservedTickets.append(ticket)
        }
        else if ticket.startDate == endDate, ticket.endDate == startDate {
            reservedTickets.append(ticket)
        }
        else if ticket.startDate < endDate, ticket.endDate > startDate {
            reservedTickets.append(ticket)
        }
        else if ticket.startDate > endDate, ticket.endDate < startDate {
            reservedTickets.append(ticket)
        }
    }
    
    func checkReservations(letter: String){
        quantity = Array(1...parking.quantity)
        let thisLevelTickets = reservedTickets.filter{$0.spotNumber.contains(letter)}
        let thisLevelSpots = thisLevelTickets.map{$0.spotNumber}
        let thisLevelNumbers = thisLevelSpots.map{Int($0.dropFirst()) ?? 0}
        for number in thisLevelNumbers {
            quantity = quantity.filter{$0 != number}
        }
        self.selectedSpot = quantity[0]
    }
    
    // Presents all levels
    func allParkingLevels(_ level: String) -> [String]{
        switch level {
        case "B":
            return ["A", "B"]
        case "C":
            return ["A", "B", "C"]
        case "D":
            return ["A", "B", "C", "D"]
        case "E":
            return ["A", "B", "C", "D", "E"]
        case "F":
            return ["A", "B", "C", "D", "E", "F"]
        case "G":
            return ["A", "B", "C", "D", "E", "F", "G"]
        default:
            return ["A"]
        }
    }
    
    func checkSummary(ticket: ParkingTicket) -> Bool{
        if ticket.spotNumber == String("\(selectedLevel)" + "\(selectedSpot)"){
            if ticket.endDate <= endDate, ticket.endDate >= startDate {
                return true
            }
            else if ticket.startDate <= endDate, ticket.startDate >= startDate{
                return true
            }
            else if ticket.startDate == startDate, ticket.endDate == endDate {
                return true
            }
            else if ticket.startDate < startDate, ticket.endDate > endDate {
                return true
            }
            else if ticket.startDate > startDate, ticket.endDate < endDate {
                return true
            }
        }
        return false
    }
    
    func generateTicket() -> ParkingTicket {
        return ParkingTicket(id: UUID().uuidString, name: self.user.name, licenseNumber: self.user.carNumber, parkingName: parking.name, address: parking.address, spotNumber: String(selectedLevel + selectedSpot.description), startDate: self.startDate, endDate: self.endDate, price: cost)
    }
}
