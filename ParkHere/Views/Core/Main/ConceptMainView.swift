//
//  ConceptMainView.swift
//  ParkHere
//
//  Created by jabko on 16/03/2023.
//

import SwiftUI
import MapKit


struct ConceptMainView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.23,longitude: 21.0),span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    @State private var searchTerm: String = ""
    @State private var isSearch: Bool = false
    
    @StateObject private var vm = ParkingSpot()
    @Binding var selectedTab: Tab
    
    var body: some View {
        NavigationStack {
            ZStack {
                // MARK: MAP
                Map(coordinateRegion: $mapRegion)
                    .ignoresSafeArea()
                    .onTapGesture { isSearch = false }
                    .opacity(isSearch ? 0.01 : 1 )
                      
                
                VStack {
                    searchBar
                     
                    if isSearch { searchView }
                    
                    
                    
                    Spacer()
                    
                   
                } // VStack
                .padding()
                .padding(.horizontal)

                TabBarView(selectedTab: $selectedTab)
            } // ZStack
            
            
        } // NavigationStack
    }
}

struct ConceptMainView_Previews: PreviewProvider {
    static var previews: some View {
        ConceptMainView(selectedTab: .constant(.map))
    }
}


struct Parking: Identifiable, Codable {
    var id = UUID().uuidString
    let name: String
    let city: String
    let street: String
    let number: String
    let zipCode: String
    let phone: Int
    
    static let sampleParking = Parking(name: "Parking Warsaw Spire", city: "Warsaw", street: "plac Europejski", number: "1", zipCode: "00-844", phone: 796541234)
}

class ParkingSpot: ObservableObject {
    // MARK: Display data
    @Published var carParks: [Parking] = []
    
    init() {
        getCarParks()
    }
    
    func getCarParks() {
        let newCarParks = [
            Parking(name: "Parking Warsaw Spire", city: "Warsaw", street: "plac Europejski", number: "1", zipCode: "00-844", phone: 796541234),
            Parking(name: "The Warsaw Hub", city: "Warsaw", street: "rondo Daszyńskiego", number: "2a", zipCode: "00-838", phone: 221662110),
            Parking(name: "Warsaw Financial Center", city: "Warsaw", street: "Emilii Plater", number: "53", zipCode: "00-113", phone: 225407090)
        ]
        self.carParks.append(contentsOf: newCarParks)
    }
}




extension ConceptMainView {
    // MARK: View components
    var searchBar: some View {
        HStack {
            Image("search")
                .flatIconImage()
            
            TextField("Search location", text: $searchTerm)
                .onTapGesture { isSearch = true }
                
            
            Image("filter")
                .flatIconImage()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .fontWeight(.semibold)
        .background(.white)
        .cornerRadius(20)
        .shadow(radius: 1)
    }
    
    var searchView: some View {
        VStack {
            Text("History")
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
                .padding(.top)
        
            
            ForEach(vm.carParks) { parking in
               ParkingSearchView(parking: parking)
            }
            
            
            Text("Saved")
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
                .padding(.top)
            
            
            ForEach(vm.carParks) { parking in
               ParkingSearchView(parking: parking)
            }
            
        }
        .opacity(isSearch ? 1 : 0)
    }
}
