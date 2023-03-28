//
//  CalView.swift
//  ParkHere
//
//  Created by jabko on 28/03/2023.
//

import SwiftUI

struct CalView: View {
    @StateObject private var vm = CalViewModel()
    
    var body: some View {
        VStack {
            DatePicker("Start date:", selection: $vm.startDate, in: Date().roundedToNearestQuarter()...Date().upToFiveDays())
            
            DatePicker("End date:", selection: $vm.endDate, in:
                        vm.startDate.minParkingTime()...vm.startDate.upToFiveDays())
            
            Spacer()
            
            Text("\(vm.startDate)")
            Text("\(vm.endDate)")
        }
        .onAppear { UIDatePicker.appearance().minuteInterval = 15 }
        .onChange(of: vm.startDate) { newValue in
            if isTimeDifferenceLessThan30Minutes(date1: vm.startDate, date2: vm.endDate) {
                vm.endDate = newValue.minParkingTime()
            }
        }
    }
}

struct CalView_Previews: PreviewProvider {
    static var previews: some View {
        CalView()
    }
}


extension CalView {
    func isTimeDifferenceLessThan30Minutes(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: date1, to: date2)
        guard let minutes = components.minute else { return false }
        return abs(minutes) < 30
    }
}

