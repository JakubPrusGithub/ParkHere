//
//  MainMapView.swift
//  ParkHere
//
//  Created by jabko on 16/03/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.23,longitude: 21.0),span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    @StateObject var allParkings = ParkingFirestoreManager()
    
    // Search
    @State private var searchTerm: String = ""
    @State private var isSearching: Bool = false
    
    // Parking
    @State private var showParkingPreview = false
    @State private var currentParking = ParkingStruct.sampleParking
    
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                // MARK: MAP
                Map(coordinateRegion: $mapRegion, annotationItems: allParkings.firestoreParkings){ parking in
                    /*
                     MapMarker(coordinate: CLLocationCoordinate2D(
                         latitude: parking.location.latitude,
                         longitude: parking.location.longitude))
                     
                      MapAnnotation causes a bug!!!
                      But MapMarker does not
                      soruce: https://developer.apple.com/forums/thread/718697
                     */
                
                    MapAnnotation(coordinate: CLLocationCoordinate2D(
                        latitude: parking.location.latitude,
                        longitude: parking.location.longitude)) {
                            
                            Image(systemName: "parkingsign.circle.fill")
                                .font(.title)
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    self.currentParking = parking
                                    self.showParkingPreview = true
                                }
                        }
                    
                }
                .ignoresSafeArea()
                .opacity(isSearching ? 0.01 : 1 )
                .animation(.linear(duration: 0.1), value: isSearching)
                .onTapGesture {
                    isSearching = false
                    searchTerm = ""
                }
                
                
                // MARK: Top Safe Area
                GeometryReader { reader in
                    Color.clear
                        .background(.ultraThinMaterial)
                        .frame(height: reader.safeAreaInsets.top, alignment: .top)
                        .ignoresSafeArea()
                }
                
                
                VStack {
                    
                    // Searchbar view component
                    SearchBarView(searchTerm: $searchTerm, isSearching: $isSearching)
                    
                    // White view with results
                    if isSearching {
                        searchView
                            .opacity(isSearching ? 1 : 0.01 )
                            .animation(.linear(duration: 0.15), value: isSearching)
                            .onTapGesture { isSearching = false }
                    }
                    Spacer()
                    
                    // Bottom sheet with preview info
                    if showParkingPreview, !isSearching {
                        ParkingDetailsPreview(parking: currentParking, isShowingPreview: $showParkingPreview)
                            .padding(.bottom, 50)
                            .animation(.linear(duration: 0.5), value: showParkingPreview)
                    }
                } // VStack
                .padding()
                
            } // ZStack
            
        } // NavigationStack
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

extension MapView {
    
    // MARK: View components
    var searchView: some View {
        VStack {
            
            Text("Results")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ForEach(searchResults) { parking in
                Button{
                    isSearching = false
                    showParkingPreview = true
                    currentParking = parking
                    mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: parking.location.latitude, longitude: parking.location.longitude),span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                } label: {
                    // Single result view component
                    ParkingResultSearchView(parking: parking)
                        .padding(.top, 10)
                        .foregroundColor(.black)
                }
                
                
                
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
