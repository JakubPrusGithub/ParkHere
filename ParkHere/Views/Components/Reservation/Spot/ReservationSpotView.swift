//
//  ReservationSpotView.swift
//  ParkHere
//
//  Created by Jakub Prus on 24/03/2023.
//

import SwiftUI

struct ReservationSpotView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject var controller: ReservationSpotViewModel
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 25){
                Text("Please choose your spot")
                    .padding(.vertical, 30)
                    .font(.title2)
                    .foregroundColor(.gray)
                // MARK: Picker
                Picker("Please select your parking level", selection: $controller.selectedLevel){
                    ForEach(controller.levels, id: \.self){
                        Text($0)
                    }
                }
                .onChange(of: controller.selectedLevel, perform: { newLetter in
                    controller.checkReservations(letter: newLetter)
                })
                .pickerStyle(.segmented)
                Picker("Please select your parking number", selection: $controller.selectedNumber){
                    ForEach(controller.quantity, id: \.self){
                        Text($0.description)
                    }
                }
                .pickerStyle(.wheel)
                
                Spacer()
                
                // MARK: Continue
                VStack{
                    NavigationLink("Continue"){
                        SummaryView(summaryTicket: controller.createTicket())
                    }
                    .buttonStyle(.sign)
                    .padding(.vertical)
                    Button("Cancel"){
                        dismiss()
                    }
                    .foregroundColor(.gray)
                    .padding(.top, -10)
                }
            }
            .padding()
            .navigationTitle("Parking spot")
        }
    }
}

struct ReservationSpotView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationSpotView(controller: ReservationSpotViewModel(myStartDate: Date(), myEndDate: Date(), parking: .sampleParking, cost: 0))
    }
}
