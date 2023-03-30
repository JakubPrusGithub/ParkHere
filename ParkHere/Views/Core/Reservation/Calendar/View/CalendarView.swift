//
//  CalView.swift
//  ParkHere
//
//  Created by jabko on 28/03/2023.
//

import SwiftUI

struct CalendarView: View {
    @StateObject private var vm = CalendarViewModel()
    let parking: ParkingStruct
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 25){
                
                // MARK: Time interval
                timeInterval
                
                Divider()
                
                // MARK: Cost
                cost
                
                Spacer()
                
                // MARK: Continue
                button
                
            }
            .padding()
            .navigationTitle("Reservation date")
            .foregroundColor(.customGrey)
            //.applyClose()
            
        }
        .onAppear { UIDatePicker.appearance().minuteInterval = 15 }
        .onChange(of: vm.startDate) { newValue in
            if Date().isTimeDifferenceLessThan(intervalInMinutes: 30,
                                               date1: vm.startDate,
                                               date2: vm.endDate) {
                vm.endDate = newValue.minParkingTime()
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(parking: .sampleParking)
    }
}


extension CalendarView {
    
    private var timeInterval: some View {
        Group {
            Text("Time interval")
                .font(.title2.weight(.semibold))
                .foregroundColor(.gray)
            
            DatePicker("Start date:",
                       selection: $vm.startDate,
                       in:Date().roundedToNearestQuarter()...Date().upToFiveDays())
            
            DatePicker("End date:",
                       selection: $vm.endDate,
                       in:vm.startDate...vm.startDate.upToFiveDays())
            
            HStack {
                Image(systemName: "info.square.fill")
                
                Text("Costs are charged for each quarter hour started")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
        }
    }
    
    private var cost: some View {
        Group {
            Text("Cost")
                .font(.title2.weight(.semibold))
                .foregroundColor(.gray)
            
            Text("Selected time: \(vm.selectedTimeInnterval())")
            Text("Cost per hour: $\(String(format: "%.2f", parking.cost))")
            Text("Your estimated cost is: $\(vm.calcCost(perHour: parking.cost).1)")
                .bold()
            
        }
    }
    
    private var button: some View {
        CustomNavLink(destination:ReservationSpotView(myStartDate: vm.startDate,
                                                      myEndDate: vm.endDate,
                                                      parking: parking,
                                                      cost: vm.calcCost(perHour: parking.cost).0),
                      title: "Continue",
                      type: .dark)
    }
}


