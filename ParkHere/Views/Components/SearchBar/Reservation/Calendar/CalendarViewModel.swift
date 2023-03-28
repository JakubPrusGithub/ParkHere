//
//  CalendarViewModel.swift
//  ParkHere
//
//  Created by Jakub Prus on 21/03/2023.
//

import Foundation

@MainActor
class CalendarViewModel: ObservableObject {
    
    @Published var startDate = Date().addingTimeInterval(900)
    @Published var endDate = Date().addingTimeInterval(900)
    
    let upToFiveDays = Date().addingTimeInterval(15*24*60*60)
    let today = Date.now
    var quarters = 0
    
    func info() -> String {
        var validTime = true
        if startDate == endDate {
            validTime = false
        }
        return validTime ? "Costs are charged for each quarter hour started" : "Please select the beginning and end of your reservation"
    }
    
    func calcTime() -> String {
        if startDate == endDate || startDate > endDate {
            return "None"
        }
        
        let calendar = Calendar.current
        
        let startMinute = calendar.component(.minute, from: startDate)
        let startHour = calendar.component(.hour, from: startDate)
        let startDay = calendar.component(.day, from: startDate)
        let startMonth = calendar.component(.month, from: startDate)
        let startComps = DateComponents(month: startMonth, day: startDay, hour: startHour, minute: startMinute)
        let startDateCalendar = Calendar.current.date(from: startComps) ?? Date()
        
        let endMinute = calendar.component(.minute, from: endDate)
        let endHour = calendar.component(.hour, from: endDate)
        let endDay = calendar.component(.day, from: endDate)
        let endMonth = calendar.component(.month, from: endDate)
        let endComps = DateComponents(month: endMonth, day: endDay, hour: endHour, minute: endMinute)
        let endDateCalendar = Calendar.current.date(from: endComps) ?? Date()
        
        var minutesDiff = Int((endDateCalendar - startDateCalendar)/60)
        if minutesDiff < 15 { return "None" }
        var hoursDiff = 0
        quarters = minutesDiff/15
        
        
        while minutesDiff >= 60 {
            minutesDiff -= 60
            hoursDiff += 1
        }
        let pluralMinutes = minutesDiff>1
        let pluralHours = hoursDiff>1
        
        if hoursDiff > 0 {
            if minutesDiff > 0{
                return String("\(hoursDiff) \(pluralHours ? "hours" : "hour"), ") + String("\(minutesDiff) \(pluralMinutes ? "minutes" : "minute")")
            }
            else{
                return String("\(hoursDiff) \(pluralHours ? "hours" : "hour")")
            }
        }
        else {
            return String("\(minutesDiff) \(pluralMinutes ? "minutes" : "minute")")
        }
    }
    
    func createReservationVM() -> ReservationSpotViewModel{
        return ReservationSpotViewModel(myStartDate: startDate, myEndDate: endDate, parking: ParkingModel.sampleParking, cost: Double(calcCost(perHour: 10)) ?? 0)
    }
    
    func calcCost(perHour: Double) -> String {
        return String(format: "%.2f", Double(quarters)*(perHour/4))
    }
}





