//
//  ReservationView.swift
//  ParkHere
//
//  Created by jabko on 31/03/2023.
//

import SwiftUI

struct ReservationView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = ReservationViewModel()
    @StateObject var listener = TicketListener()
    @State private var currentScreen: Int = 1
    let parking: ParkingStruct
    
    init(parking: ParkingStruct) {
        self.parking = parking
        _ = Dependencies()
    }
    
    var body: some View {
        VStack(spacing: 20) {
            
            // MARK: Top bar
            headerReservationView
            
            // MARK: Display current screen
            VStack {
                switch currentScreen {
                case 1: ParkDetailsView(parking: parking)
                case 2: CalendarView(parking: parking)
                case 3: ReservationSpotView(parking: parking)
                case 4: SummaryView(currentScreen: $currentScreen, parking: parking)
                case 5: TicketGenerationView(ticket: vm.generateTicket())
                default:
                    Text("Nothing")
                }
            }
            .onAppear{
                vm.parking = parking
            }
            
            // MARK: Button
            navigationButton
            
        }
        .padding()
        .toolbar(.hidden, for: .navigationBar)
        .environmentObject(vm)
        .environmentObject(listener)
    }
}

struct ReservationView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationView(parking: .sampleParking)
    }
}


extension ReservationView {
    
    private var headerReservationView: some View {
        HStack {
            Button {
                currentScreen -= 1
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.customGrey)
                    .font(.title3.weight(.semibold))
                    .opacity((currentScreen == 1 || currentScreen == 5 ) ? 0 : 1)
            }
            .disabled(currentScreen == 1 || currentScreen == 5)
            
            
            Text(currentScreen == 4 ? "Summary" : "")
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .center)
            
            CloseButtonView(image: "xmark", alignment: .trailing)
                .opacity((currentScreen == 1 || currentScreen == 5 ) ? 0 : 1)
                .disabled(currentScreen == 1 || currentScreen == 5)
        }
    }
    
    private var navigationButton: some View {
        Button {
            if currentScreen < 5 {
                currentScreen += 1
            }
            else{
                dismiss()
            }
        } label: {
            Text(currentScreen < 5 ? "Continue" : "OK")
                .customBackground(type: .dark)
        }
        
    }
    
}
