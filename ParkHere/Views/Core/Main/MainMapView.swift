//
//  MainMapView.swift
//  ParkHere
//
//  Created by jabko on 16/03/2023.
//

import SwiftUI
import MapKit


struct MainMapView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.23,longitude: 21.0),span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    @State private var searchTerm: String = ""
    @State private var isSearch: Bool = false
    @StateObject var allParkings = ParkingFirestoreManager()
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                // MARK: MAP
                Map(coordinateRegion: $mapRegion, annotationItems: allParkings.firestoreParkings){ parking in
                    MapMarker(coordinate: CLLocationCoordinate2D(
                        latitude: parking.location.latitude,
                        longitude: parking.location.longitude))
                }
                .ignoresSafeArea()
                .onTapGesture { isSearch = false }
                .opacity(isSearch ? 0.01 : 1 )
                .animation(.linear(duration: 0.1), value: isSearch)
                
                GeometryReader { reader in
                    Color.clear
                        .background(.ultraThinMaterial)
                        .frame(height: reader.safeAreaInsets.top, alignment: .top)
                        .ignoresSafeArea()
                }
                VStack {
                    searchBar
                    
                    if isSearch {
                        searchView
                            .opacity(isSearch ? 1 : 0.01 )
                            .animation(.linear(duration: 0.15), value: isSearch)
                    }
                    Spacer()
                    
                } // VStack
                .padding()
                
                TabBarView(selectedTab: $selectedTab)
            } // ZStack
            
        } // NavigationStack
    }
}

struct ConceptMainView_Previews: PreviewProvider {
    static var previews: some View {
        MainMapView(selectedTab: .constant(.map))
    }
}

extension MainMapView {
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
            Text("Results")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ForEach(searchResults) { parking in
                // TODO: Present new view after click
                ParkingResultSearchView(parking: parking)
                    .padding(.top, 10)
                
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    // MARK: Search results
    var searchResults: [ParkingStruct] {
        if searchTerm.isEmpty{
            return allParkings.firestoreParkings
        }
        else{
            return allParkings.firestoreParkings.filter{$0.name.contains(searchTerm)}
        }
    }
}
