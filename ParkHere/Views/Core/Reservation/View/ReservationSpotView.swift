//
//  ReservationSpotView.swift
//  ParkHere
//
//  Created by Jakub Prus on 24/03/2023.
//

import SwiftUI

struct ReservationSpotView: View {
    @EnvironmentObject var vm: ReservationViewModel
    @EnvironmentObject var listener: TicketListener
    @State var parking: ParkingStruct
    
    
    init(parking: ParkingStruct) {
        self.parking = parking
        _ = Dependencies()
    }
    
    var body: some View {
        VStack(spacing: 25){
            
            Text("Please scroll and select your spot:")
                .font(.title2)
                .foregroundColor(.gray)
            
            Picker("Please select your parking level", selection: $vm.selectedLevel){
                ForEach(vm.levels, id: \.self) {
                    Text($0.description)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: vm.selectedLevel) { newLetter in
                vm.checkReservations(letter: newLetter)
            }
            
            SpotSelection()
            
        }
        .onAppear {
            self.parking = vm.parking
            vm.checkReservations(letter: vm.selectedLevel)
            vm.checkTicket()
            vm.levels = vm.allParkingLevels(parking.level)
        }
        .onChange(of: listener.newTicket) { newTicket in
            vm.checkIfColliding(ticket: newTicket)
            vm.checkTicket()
            vm.checkReservations(letter: vm.selectedLevel)
        }
    }
}

struct ReservationSpotView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationView(parking: .sampleParking)
            .environmentObject(ReservationViewModel())
    }
}



