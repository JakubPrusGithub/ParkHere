//
//  ParkDetailsView.swift
//  ParkHere
//
//  Created by jabko on 31/03/2023.
//

import SwiftUI
import MapKit

struct ParkDetailsView: View {
    @State var parkings = [ParkingStruct]()
    @State var mapRegion = MKCoordinateRegion()
    @State var parking: ParkingStruct
    @EnvironmentObject var vm: ReservationViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            // MARK: Location + sample description
            parkingNameAndLocation
            
            Divider()
            
            // MARK: Parkin area
            parkingArea
            
            Divider()
            
            // MARK: Cost
            cost
            
            Spacer()
        }
        .onAppear{
            self.parking = vm.parking
            self.parkings.append(parking)
            mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: parking.location.latitude, longitude: parking.location.longitude),span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008))
        }
    }
}

struct ParkDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationView(parking: .sampleParking)
    }
}


// MARK: View
extension ParkDetailsView {
    
    private var parkingNameAndLocation: some View {
        Group{
            Text(parking.name)
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Map(coordinateRegion: $mapRegion, annotationItems: parkings){parking in
                MapMarker(coordinate: CLLocationCoordinate2D(
                    latitude: parking.location.latitude,
                    longitude: parking.location.longitude))
            }
            .disabled(true)
            .cornerRadius(15)
            .shadow(radius: 3)
            .frame(height: 150)
            
            HStack{
                Image(systemName: "mappin.and.ellipse")
                
                Text(parking.address)
            }
            .font(.title2.weight(.semibold))
            .foregroundColor(.gray)
            .padding(.vertical, 5)
            
            Text(parking.description)
                .font(.footnote)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                .padding(.vertical, 5)
            
          
        }
    }
    
    private var parkingArea: some View {
        Group{
            Text("Parking area")
                .font(.title2.weight(.semibold))
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
        }
    }
    
    private var cost: some View {
        Group{
            Text("Cost")
                .font(.title2.weight(.semibold))
                .foregroundColor(.gray)
            
            HStack{
                Image(systemName: "dollarsign.circle.fill")
                    .font(.title2)
                Text("$\(String(format: "%.2f", parking.cost)) per hour")
            }
            .padding(.vertical, 5)
        }
    }

}

// MARK: Func
extension ParkDetailsView{
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
