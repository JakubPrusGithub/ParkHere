//
//  CalendarView.swift
//  ParkHere
//
//  Created by Jakub Prus on 21/03/2023.
//

import SwiftUI

struct CalendarView: View {
    
    let parking: ParkingModel
    @Environment(\.dismiss) private var dismiss
    @StateObject var controller = CalendarViewModel()
    
    @State private var invalidTime = false
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 25){
                
                // MARK: Time interval
                Group{
                    Text("Time interval")
                        .font(.title2)
                        .foregroundColor(.gray)
                    DatePicker("Start date:", selection: $controller.startDate, in:controller.today...controller.upToFiveDays)
                    DatePicker("End date:", selection: $controller.endDate, in:controller.startDate...controller.upToFiveDays)
                        .onAppear {
                            UIDatePicker.appearance().minuteInterval = 15
                        }
                        .onDisappear {
                            UIDatePicker.appearance().minuteInterval = 1
                        }
                    HStack{
                        Image(systemName: "info.circle.fill")
                        Text(controller.info())
                    }
                    .foregroundColor(.gray)
                }
                
                Divider()
                
                // MARK: Cost
                Group{
                    Text("Cost")
                        .font(.title2)
                        .foregroundColor(.gray)
                    Text("Selected time: \(controller.calcTime())")
                    Text("Cost per hour: $\(String(format: "%.2f", parking.cost))")
                    Text("Your estimated cost is: $\(controller.calcCost(perHour: parking.cost))")
                        .bold()
                    
                    Text("\(controller.startDate)")
                }
                
                Spacer()
                
                // MARK: Continue
                VStack{
                    NavigationLink("Continue"){
                        //ReservationSpotView(controller: ReservationSpotViewModel())
                        ReservationSpotView(myStartDate: controller.startDate, myEndDate: controller.endDate, parking: parking, cost: Double(controller.calcCost(perHour: parking.cost)) ?? 0)
                        //ReservationSpotView(controller: ReservationSpotViewModel(myStartDate: controller.startDate, myEndDate: controller.endDate, parking: parking, cost: Double(controller.calcCost(perHour: parking.cost)) ?? 0))
                        //print(ReservationSpotViewModel(myStartDate: controller.startDate, myEndDate: controller.endDate, parking: parking, cost: Double(controller.calcCost(perHour: parking.cost)) ?? 0))
                        //ReservationSpotView(controller: controller.createReservationVM())
                    }
                    .disabled(controller.calcTime() == "None")
                    .buttonStyle(.sign)
                    .padding(.vertical)
                    
                    Button("Cancel"){
                        dismiss()
                    }
                    .foregroundColor(.gray)
                    .padding(.top, -10)
                }
                
                
            }
            .navigationTitle("Reservation date")
            .padding()
            .foregroundColor(.customGrey)
            
        }
    }
}

struct CallendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(parking: .sampleParking)
    }
}
