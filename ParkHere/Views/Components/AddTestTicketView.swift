//
//  AddTestTicketView.swift
//  ParkHere
//
//  Created by Jakub Prus on 24/03/2023.
//


import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct AddTestTicketView: View {
    
    @State var nowyOd = Date()
    @State var nowyDo = Date().addingTimeInterval(3600)
    
    @State var mojOd = Date()
    @State var mojDo = Date().addingTimeInterval(3600)
    
    @State var allTickets = [ParkingTicket]()
    @State var reservedTickets = [ParkingTicket]()
    
    let db = Firestore.firestore()
    
    var body: some View {
        VStack{
            Group{
                Spacer()
                DatePicker("nowy od", selection: $nowyOd)
                DatePicker("nowy od", selection: $nowyDo)
                Button("new Ticket"){
                    newTicket()
                }
                Spacer()
            }
            DatePicker("moj od", selection: $mojOd)
                .foregroundColor(.purple)
            DatePicker("moj do", selection: $mojDo)
                .foregroundColor(.purple)
            Button("moj testowy"){
                //nic
            }
            Text("Moj bilecik: \nod \(mojOd.formatted()) \ndo \(mojDo.formatted())")
            Spacer()
            ScrollView{
                Text("All")
                ForEach(allTickets){ ticket in
                    Text("\(ticket.startDate.formatted()) - \(ticket.endDate.formatted())")
                }
            }
            .frame(width: 350)
            .background{
                Color.gray
            }
            ScrollView{
                Text("reserved")
                ForEach(reservedTickets){ reserved in
                    Text("\(reserved.startDate.formatted()) - \(reserved.endDate.formatted())")
                }
            }
            .frame(width: 350)
            .background{
                Color.mint
            }
            Button("refresh"){
                refreshFirebase()
            }
            
        }
    }
}

struct AddTestTicketView_Previews: PreviewProvider {
    static var previews: some View {
        AddTestTicketView()
    }
}

//struct ParkingTicket: Codable, Identifiable, Hashable {
//    @DocumentID var id: String?
//    let name: String
//    let licenseNumber: String
//    let parkingName: String
//    let address: String
//    let spotNumber: String
//    let startDate: Date
//    let endDate: Date
//    let price: Double
//}

extension AddTestTicketView {
    
    func refreshFirebase() {
        allTickets = []
        reservedTickets = []
        let ref = db.collection("ticket")
        let query = ref.whereField("parkingName", isEqualTo: "Parking")
        query.getDocuments { querySnapshot, err in
            guard let results = querySnapshot else { return print("Error getting documents: \(err!.localizedDescription)")}
            
            for result in results.documents{
                do {
                    let ticket = try result.data(as: ParkingTicket.self)
                    self.allTickets.append(ticket)
                    checkIfColliding(ticket: ticket)
                }
                catch{
                    print("Failed to decode: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func checkIfColliding(ticket: ParkingTicket){
        if ticket.endDate <= mojDo, ticket.endDate >= mojOd {
            reservedTickets.append(ticket)
        }
        else if ticket.startDate <= mojDo, ticket.startDate >= mojOd{
            reservedTickets.append(ticket)
        }
        else if ticket.startDate == mojOd, ticket.endDate == mojDo {
            reservedTickets.append(ticket)
        }
        else if ticket.startDate < mojOd, ticket.endDate > mojDo {
            reservedTickets.append(ticket)
        }
        else if ticket.startDate > mojOd, ticket.endDate < mojDo {
            reservedTickets.append(ticket)
        }
    }
    
    func newTicket(){
        
        let ticketNumber = String(UUID().uuidString.prefix(8))

        let parkingTicketData: [String: Any] = [
            "id": ticketNumber,
            "name": "Imie Nazwisko",
            "licenseNumber": "AB 12345",
            "parkingName": "Parking",
            "address": "Official Street, Warsaw",
            "spotNumber": "A99",
            "startDate": nowyOd,
            "endDate": nowyDo,
            "price": 10.50
        ]

        db.collection("ticket").document(ticketNumber).setData(parkingTicketData) { error in
            if let error = error {
                print("Błąd przy dodawaniu biletu parkingowego: \(error.localizedDescription)")
            } else {
                print("Bilet parkingowy został dodany do bazy danych Firestore")
            }
        }

    }
}

