//
//  ParkingDetailsView.swift
//  ParkHere
//
//  Created by Jakub Prus on 20/03/2023.
//

import SwiftUI
import MapKit

struct ParkingDetailsView: View {
    
    let parking: ParkingStruct
    @State var parkings = [ParkingStruct]()
    @State var mapRegion = MKCoordinateRegion()
    
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack(alignment: .leading){
                    
                    // MARK: Location
                    Text("Location")
                        .font(.title2)
                        .foregroundColor(.gray)
                    HStack{
                        VStack(alignment: .leading, spacing: 20){
                            HStack{
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.title2)
                                Text(parking.address)
                            }
                            Text(parking.description)
                                .font(.callout)
                            
                        }
                        //.padding(.vertical)
                        
                        // Non-interactive map
                        Map(coordinateRegion: $mapRegion, annotationItems: parkings){parking in
                            MapMarker(coordinate: CLLocationCoordinate2D(
                                latitude: parking.location.latitude,
                                longitude: parking.location.longitude))
                        }
                        .disabled(true)
                        .cornerRadius(15)
                        .shadow(radius: 3)
                        
                    }
                    .frame(height: 200)
                    Divider()
                    
                    // MARK: Parkin area
                    Text("Parking area")
                        .font(.title2)
                        .foregroundColor(.gray)
                    VStack(alignment: .leading, spacing: 10){
                        HStack{
                            Image(systemName: "clock")
                                .font(.title2)
                            Text("Available 24 hours, 7 days a week")
                        }
                        HStack{
                            Image(systemName: "square.stack.3d.up.fill")
                                .font(.title2)
                            Text("General levels: " + allParkingLevels(parking.level))
                        }
                        HStack{
                            Image(systemName: "number")
                                .font(.title2)
                            Text("Spots per level: " + parking.quantity.description)
                        }
                        HStack{
                            Image(systemName: parking.guarded ? "checkmark.shield.fill" : "xmark.shield.fill")
                                .font(.title2)
                            Text(parking.guarded ? "Guarded" : "Not guarded")
                        }
                    }
                    .padding(.vertical, 5)
                    Divider()
                    
                    // MARK: Cost
                    Text("Cost")
                        .font(.title2)
                        .foregroundColor(.gray)
                    VStack(alignment: .leading, spacing: 10){
                        HStack{
                            Image(systemName: "dollarsign.circle.fill")
                                .font(.title2)
                            Text("$\(String(format: "%.2f", parking.cost)) per hour")
                        }
                    }
                    .padding(.vertical, 5)
                    
                    Spacer()
                    
                    // MARK: Continue
                    Button("Reserve your parking spot"){
                        // TODO: Callendar view with reservation
                    }
                    .buttonStyle(.sign)
                    .padding()
                    
                } // VStack
                .padding()
                .navigationTitle(deleteParkingPrefix(parking.name))
                .navigationBarTitleDisplayMode(.large)
            }
            
        } // NavigationStack
        .foregroundColor(.customGrey)
        .onAppear{
            self.parkings.append(parking)
            mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: parking.location.latitude, longitude: parking.location.longitude),span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008))
        }
    }
}

extension ParkingDetailsView{
    func allParkingLevels(_ level: String) -> String{
        switch level {
        case "B":
            return "A, B"
        case "C":
            return "A, B, C"
        case "D":
            return "A, B, C, D"
        case "E":
            return "A, B, C, D, E"
        case "F":
            return "A, B, C, D, E, F"
        case "G":
            return "A, B, C, D, E, F, G"
        default:
            return "A"
        }
    }
    
    func deleteParkingPrefix(_ name: String) -> String{
        guard name.hasPrefix("Parking") else { return name }
        return String(name.dropFirst("Parking ".count))
    }
}

struct ParkingDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ParkingDetailsView(parking: ParkingStruct.sampleParking)
    }
}
