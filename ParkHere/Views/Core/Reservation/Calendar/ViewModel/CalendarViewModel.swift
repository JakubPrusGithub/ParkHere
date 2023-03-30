//
//  CalViewModel.swift
//  ParkHere
//
//  Created by jabko on 28/03/2023.
//

import Foundation


class CalendarViewModel: ObservableObject {
    
    @Published var startDate: Date
    @Published var endDate: Date

    init(startDate: Date = .now, endDate: Date = .now) {
        self.startDate = startDate.roundedToNearestQuarter()
        self.endDate = endDate.minParkingTime()
    }
    
    let calendar = Calendar.current
    
    
    // TODO: Return - Selected time
    func selectedTimeInnterval() -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .hour, .minute], from: startDate, to: endDate)
        
        var timeComponents: [String] = []
        
        if let days = components.day, days > 0 {
            timeComponents.append("\(days) \(days == 1 ? "day" : "days")")
        }
        
        if let hours = components.hour, hours > 0 {
            timeComponents.append("\(hours) \(hours == 1 ? "hour" : "hours")")
        }
        
        if let minutes = components.minute {
            timeComponents.append("\(minutes)" + " minutes")
        }
        
        return timeComponents.joined(separator: ", ")
    }
    
    
    // TODO: Return - Your estimated cost is:
    func calcCost(perHour: Double) -> (Double, String) {
        let component = calendar.dateComponents([.minute], from: startDate, to: endDate)
        var quarters: Double = 0
        
        if let minutes = component.minute {
            quarters = Double(minutes/15)
        }
        
       return (quarters, String(format: "%.2f", Double(quarters)*(perHour/4)))
    }
   
}









