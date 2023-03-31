//
//  CalView.swift
//  ParkHere
//
//  Created by jabko on 28/03/2023.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var vm: ReservationViewModel
    @State var parking: ParkingStruct
    
    init(parking: ParkingStruct) {
        self.parking = parking
        _ = Dependencies()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 25){
            // MARK: Header
            headerCalendar
            
            // MARK: Time interval
            timeInterval
            
            Divider()
            
            // MARK: Cost
            cost
            
            Spacer()
             
        }
        .onAppear {
            self.parking = vm.parking
            UIDatePicker.appearance().minuteInterval = 15
        }
        .onChange(of: vm.startDate) { newValue in
            if Date().isTimeDifferenceLessThan(intervalInMinutes: 30,
                                               date1: vm.startDate,
                                               date2: vm.endDate) {
                vm.endDate = newValue.minParkingTime()
            }
        }
        .onDisappear{
            vm.calcFinalCost()
        }
    }
}


struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(parking: .sampleParking)
            .environmentObject(ReservationViewModel())
    }
}


extension CalendarView {
    
    private var headerCalendar: some View {
        Text("Reservation date")
            .font(.title2)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
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

}


