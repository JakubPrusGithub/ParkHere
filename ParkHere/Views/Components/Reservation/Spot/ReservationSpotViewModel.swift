//
//  ReservationSpotViewModel.swift
//  ParkHere
//
//  Created by Jakub Prus on 26/03/2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

@MainActor
class ReservationSpotViewModel: ObservableObject{
    
    // Firebase
    @Published var reservedTickets = [ParkingTicket]()
    var allTickets = [ParkingTicket]()
    let db = Firestore.firestore()
    
    // Data from CalendarView
    var myStartDate = Date()
    var myEndDate = Date()
    var parking = ParkingStruct.sampleParking
    var cost = Double()
    
    // Actual view data
    @Published var levels = [String]()
    @Published var quantity = [Int]()
    @Published var selectedLevel = "A"
    @Published var selectedNumber = 0
    
    init(reservedTickets: [ParkingTicket] = [ParkingTicket](), allTickets: [ParkingTicket] = [ParkingTicket](), myStartDate: Date = Date(), myEndDate: Date = Date(), parking: ParkingStruct = .sampleParking, cost: Double = 0.0) {
        self.reservedTickets = reservedTickets
        self.allTickets = allTickets
        self.myStartDate = myStartDate
        self.myEndDate = myEndDate
        self.parking = parking
        self.cost = cost
    }
    
    // On appear
    func startFetching(start: Date, end: Date, parking: ParkingStruct, cost: Double){
        self.myStartDate = start
        self.myEndDate = end
        self.parking = parking
        self.cost = cost
        levels = allParkingLevels(parking.level)
        quantity = Array(1...parking.quantity)
        fetchTickets()
    }
    
    // Downloading all tickets from firestore based on selected parking
    func fetchTickets(){
        allTickets = []
        reservedTickets = []
        let ref = db.collection("ticket")
        let query = ref.whereField("parkingName", isEqualTo: parking.name)
        query.getDocuments { querySnapshot, err in
            guard let results = querySnapshot else { return print("Error getting documents: \(err!.localizedDescription)")}
            for result in results.documents{
                do {
                    let ticket = try result.data(as: ParkingTicket.self)
                    self.allTickets.append(ticket)
                    self.checkIfColliding(ticket: ticket)
                    self.checkReservations(letter: self.selectedLevel)
                }
                catch{
                    print("Failed to decode: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func createTicket() -> ParkingTicket {
        let spotNumber = "\(selectedLevel)" + "\(selectedNumber)"
        return ParkingTicket(name: "Imie Nazwisko", licenseNumber: "AB 12345", parkingName: parking.name, address: parking.address, spotNumber: spotNumber, startDate: myStartDate, endDate: myEndDate, price: cost)
    }
    
    // Shows only unoccupied parking numbers based on level
    func checkReservations(letter: String){
        quantity = Array(1...parking.quantity)
        let thisLevelTickets = reservedTickets.filter{$0.spotNumber.contains(letter)}
        let thisLevelSpots = thisLevelTickets.map{$0.spotNumber}
        let thisLevelNumbers = thisLevelSpots.map{Int($0.dropFirst()) ?? 0}
        for number in thisLevelNumbers {
            quantity = quantity.filter{$0 != number}
        }
    }
    
    // Checks if ticket is colliding with user's reservation
    func checkIfColliding(ticket: ParkingTicket){
        if ticket.endDate <= myEndDate, ticket.endDate >= myStartDate {
            reservedTickets.append(ticket)
        }
        else if ticket.startDate <= myEndDate, ticket.startDate >= myStartDate{
            reservedTickets.append(ticket)
        }
        else if ticket.startDate == myStartDate, ticket.endDate == myEndDate {
            reservedTickets.append(ticket)
        }
        else if ticket.startDate < myStartDate, ticket.endDate > myEndDate {
            reservedTickets.append(ticket)
        }
        else if ticket.startDate > myStartDate, ticket.endDate < myEndDate {
            reservedTickets.append(ticket)
        }
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
}

