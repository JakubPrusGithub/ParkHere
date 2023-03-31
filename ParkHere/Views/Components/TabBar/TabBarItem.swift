//
//  TabBarItem.swift
//  ParkHere
//
//  Created by jabko on 28/03/2023.
//

import Foundation
import SwiftUI

enum TabBarItem: Hashable {
    case ticket
    case map
    case profile
    
    var iconName: String {
        switch self {
        case .ticket: return "ticket"
        case .map: return "map"
        case .profile: return "profil"
        }
    }
    
    
    var title: String {
        switch self {
        case .ticket: return "Ticket"
        case .map: return "Map"
        case .profile: return "Profil"
        }
    }
}



struct TabBarItemsPreferenceKey: PreferenceKey {
    static var defaultValue: [TabBarItem] = []
    
    static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
        value += nextValue()
    }
    
}




