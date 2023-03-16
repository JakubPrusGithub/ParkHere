//
//  MapView.swift
//  ParkHere
//
//  Created by Jakub Prus on 12/03/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.2, longitude: 21.0), span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
    
    var body: some View {
        ZStack{
            Map(coordinateRegion: $mapRegion)
            Circle()
                .fill(.gray)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button {
                        //
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                    .padding()
                    .background(.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                    .padding(20)
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
