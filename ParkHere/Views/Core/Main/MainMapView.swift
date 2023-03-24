//
//  MainMapView.swift
//  ParkHere
//
//  Created by Jakub Prus on 15/03/2023.
//

import SwiftUI
import MapKit

struct MainMapView: View {
    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.23, longitude: 21.0), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @State private var truebool = true
    @State private var temp = ""
    
    var body: some View {
        ZStack(alignment: .top){
            Map(coordinateRegion: $mapRegion)
                .ignoresSafeArea()
            GeometryReader { reader in
                Color.clear
                    .background(.ultraThinMaterial)
                    .frame(height: reader.safeAreaInsets.top, alignment: .top)
                    .ignoresSafeArea()
            }
            VStack{
                Text("Find your parking")
                    .padding()
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .background(Color.customGrey.opacity(0.85))
                    .font(.title2)
                    .cornerRadius(10)
                    .padding()
                Spacer()
                HStack{
                    Spacer()
                    Button {
                        //wyszukiwarka
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                    .padding()
                    .background(Color.customGrey.opacity(0.85))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(30)
                }
            }
        }
        .sheet(isPresented: $truebool) {
            SheetSearchView()
                //.presentationBackgroundInteraction(.enabled)
                .presentationDetents([.height(100),.large])
                .presentationDragIndicator(.visible)
                .interactiveDismissDisabled(true)
                
        }
        
    }
}

struct MainMap_Previews: PreviewProvider {
    static var previews: some View {
        MainMapView()
    }
}
