//
//  MainMapView.swift
//  ParkHere
//
//  Created by jabko on 16/03/2023.
//

import SwiftUI
import MapKit

@MainActor
struct MapView: View {
    @StateObject var vm = MapViewModel()
    @State var mapRegion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.23,longitude: 21.0),span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    init() { _ = Dependencies() }
    
    // Search
    @State private var searchTerm: String = ""
    @State private var isSearching: Bool = false
    
    // Parking
    @State private var showParkingPreview = false
    @State private var currentParking = ParkingStruct.sampleParking
    
    @State private var showReservation: Bool = false
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                // MARK: MAP
                mapView
                
                // MARK: Top Safe Area
                topSafeArea
                
                
                VStack {
                    
                    // Searchbar view component
                    SearchBarView(searchTerm: $searchTerm, isSearching: $isSearching)
                    
                    // White view with results
                    if isSearching { searchView }
                    
                    Spacer()
                    
                    // Bottom sheet with preview info
                    if showParkingPreview, !isSearching {
                        ParkingDetailsPreview(parking: currentParking, isShowingPreview: $showParkingPreview, showReservation: $showReservation)
                            .padding(.bottom, 50)
                            .animation(.linear(duration: 0.5), value: showParkingPreview)
                    }
                } // VStack
                .padding()
                .onAppear { Task { try await vm.fetchParkings() } }
                .fullScreenCover(isPresented: $showReservation) {
                    ReservationView(parking: currentParking)
                }
                
            } // ZStack
            
        } // NavigationStack
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}

// MARK: View components
extension MapView {
    
    private var topSafeArea: some View {
        GeometryReader { reader in
            Color.clear
                .background(.ultraThinMaterial)
                .frame(height: reader.safeAreaInsets.top, alignment: .top)
                .ignoresSafeArea()
        }
    }
    
    private var mapView: some View {
        Map(coordinateRegion: $mapRegion, annotationItems: vm.parkings) { parking in
            
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
    }
    
    private var searchView: some View {
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
        .opacity(isSearching ? 1 : 0.01 )
        .animation(.linear(duration: 0.15), value: isSearching)
        .onTapGesture {
            isSearching = false
            showParkingPreview = false
        }
    }
    
}


// MARK: Search results
extension MapView {
    
    private var searchResults: [ParkingStruct] {
        if searchTerm.isEmpty{
            return vm.parkings
        }
        else{
            return vm.parkings.filter{$0.name.contains(searchTerm)}
        }
    }
}

