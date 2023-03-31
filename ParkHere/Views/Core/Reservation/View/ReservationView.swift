//
//  ReservationView.swift
//  ParkHere
//
//  Created by jabko on 31/03/2023.
//

import SwiftUI

struct ReservationView: View {
    @StateObject private var vm = ReservationViewModel()
    @State private var currentScreen: Int = 4
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
                case 4: SummaryView(summaryTicket: .sampleTicket)
                default:
                    Text("test")
                }
            }
            
            
            // MARK: Button
            navigationButton
            
        }
        .padding()
        .toolbar(.hidden, for: .navigationBar)
        .environmentObject(vm)
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
                    .opacity(currentScreen == 1 ? 0 : 1)
            }
            
            
            Text(currentScreen == 4 ? "Summary" : "")
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .center)
            
            CloseButtonView(image: "xmark", alignment: .trailing)
        }
    }
    
    private var navigationButton: some View {
        Button {
            currentScreen += 1
        } label: {
            Text("Reserve your parking spot")
        }
        .customBackground(type: .dark)
    }
    
}
