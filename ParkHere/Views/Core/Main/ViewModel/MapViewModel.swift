//
//  MapViewModel.swift
//  ParkHere
//
//  Created by jabko on 30/03/2023.
//

import Foundation


class MapViewModel: ObservableObject {
    @Inject var parkingData: ParkingServiceProtocol
    @Published var parkings: [ParkingStruct] = []
    
    
    @MainActor
    func fetchParkings() async throws {
        self.parkings = try await parkingData.fetchParkings()
    }
}
