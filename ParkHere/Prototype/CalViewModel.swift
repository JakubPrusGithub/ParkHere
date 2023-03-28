//
//  CalViewModel.swift
//  ParkHere
//
//  Created by jabko on 28/03/2023.
//

import Foundation


class CalViewModel: ObservableObject {
    
    @Published var startDate: Date
    @Published var endDate: Date

    init(startDate: Date = .now, endDate: Date = .now) {
        self.startDate = startDate.roundedToNearestQuarter()
        self.endDate = endDate.minParkingTime()
    }
   
}

extension Date {
    func roundedToNearestQuarter() -> Date {
        let components = Calendar.current.dateComponents([.hour, .minute], from: self)
        let minute = components.minute ?? 0
        let roundedMinute = (minute + 14) / 15 * 15
        let roundedDate = Calendar.current.date(bySettingHour: components.hour ?? 0,
                                                minute: roundedMinute,
                                                second: 0, of: self) ?? self
        
        return roundedDate
    }
    
    func minParkingTime() -> Date {
        guard let date = Calendar.current.date(byAdding: .minute, value: 15, to: self.roundedToNearestQuarter())
        else { return Date() }
        return date
    }
    
    func upToFiveDays() -> Date {
        guard let date = Calendar.current.date(byAdding: .day, value: 5, to: self)
        else { return self }
        
        return date
    }
    
   
}
