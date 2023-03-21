//
//  SubstractingDates.swift
//  ParkHere
//
//  Created by Jakub Prus on 21/03/2023.
//

import Foundation

extension Date{
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
