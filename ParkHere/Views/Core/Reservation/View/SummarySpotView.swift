//
//  SummaryView.swift
//  ParkHere
//
//  Created by Jakub Prus on 26/03/2023.
//

import SwiftUI

struct SummaryView: View {
    @EnvironmentObject var vm: ReservationViewModel
    @EnvironmentObject var listener: TicketListener
    @State private var occupied = false
    @Binding var currentScreen: Int
    @State var parking: ParkingStruct
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // MARK: Parking Details
            parkingDetails
            
            // MARK: Personal Details
            personalDetails
            
            // MARK: Reservation details
            reservationDetails
            
            // MARK: Total
            total
            
            Spacer()
            
        }
        .alert("We are sorry, but this place has just been reserved", isPresented: $occupied) {
            Button("OK", role: .cancel) {
                currentScreen -= 1
            }
        }
        .onChange(of: listener.newTicket) { newTicket in
            occupied = vm.checkSummary(ticket: newTicket)
            vm.checkIfColliding(ticket: newTicket)
            vm.checkReservations(letter: vm.selectedLevel)
            vm.checkTicket()
            vm.levels = vm.allParkingLevels(parking.level)
        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationView(parking: .sampleParking)
    }
}



extension SummaryView {
    
    private var parkingDetails: some View {
        Group{
            Text("Parking Details")
                .reservationTitle()
                .padding(.top)
            Text(vm.parking.name)
                .font(.title3.bold())
            Text(vm.parking.address)
                .padding(.vertical, -10)
            
            Divider()
        }
        .foregroundColor(.customGrey)
    }
    
    private var personalDetails: some View {
        Group{
            Text("Personal Details")
                .reservationTitle()
                .padding(.top)
            Text(vm.name)
                .font(.title3)
                .bold()
            Text("License number: " + vm.licenseNumber)
                .padding(.vertical, -10)
            
            Divider()
        }
        .foregroundColor(.customGrey)
    }
    
    private var reservationDetails: some View {
        Group{
            Text("Reservation Details")
                .reservationTitle()
                .padding(.top)
            Text("Spot: " + vm.selectedLevel + vm.selectedSpot.description)
                .font(.title3)
                .bold()
            Text(vm.startDate.formatted() + " - " + vm.endDate.formatted())
                .padding(.vertical, -10)
            
            Divider()
        }
        .foregroundColor(.customGrey)
    }
    
    private var total: some View {
        Group{
            HStack{
                Text("Total:")
                    .font(.title)
                Spacer()
                Text("$" + vm.cost.description)
                    .font(.title.bold())
            }
            .padding(.top)
        }
        .foregroundColor(.customGrey)
    }
    
}
