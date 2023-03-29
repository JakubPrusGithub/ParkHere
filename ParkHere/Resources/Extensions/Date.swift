//
//  Date.swift
//  ParkHere
//
//  Created by jabko on 29/03/2023.
//

import Foundation

extension Date {
    func roundedToNearestQuarter() -> Date {
        let components = Calendar.current.dateComponents([.hour, .minute], from: self)
        let minute = components.minute ?? 0
        
        var roundedMinute: Int
        if minute > 45 {
            roundedMinute = 0
            let hour = components.hour ?? 0 + 1
            return Calendar.current.date(bySettingHour: hour,
                                         minute: roundedMinute,
                                         second: 0, of: self) ?? self
        } else {
            roundedMinute = (minute + 14) / 15 * 15
            return Calendar.current.date(bySettingHour: components.hour ?? 0,
                                        minute: roundedMinute,
                                        second: 0, of: self) ?? self
        }

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
    
    
    func isTimeDifferenceLessThan(intervalInMinutes min: Int, date1: Date, date2: Date) -> Bool{
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: date1, to: date2)
        guard let minutes = components.minute else { return false }
        return abs(minutes) < min
    }
    
}
