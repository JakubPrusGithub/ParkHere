//
//  ParkingDetailsPreview.swift
//  ParkHere
//
//  Created by Jakub Prus on 19/03/2023.
//

import SwiftUI

struct ParkingDetailsPreview: View {
    let parking: ParkingStruct
    @Binding var isShowingPreview: Bool
    @State private var offset = CGSize.zero
    
    var body: some View {
            HStack{
                
                // MARK: Description parking
                description
                
                // MARK: Navigation buttons
                buttons

            }
            .shadowBorderBackground()
            .frame(maxHeight: 150)
            .offset(x: 0, y: offset.height)
            .opacity(2 - Double(abs(offset.height / 50)))
            .gesture(
                DragGesture()
                    .onChanged {
                        offset = $0.translation
                        if offset.height < 0 {
                            offset = .zero
                        }
                    }
                    .onEnded { _ in
                        if abs(offset.height) > 100 {
                            self.isShowingPreview = false
                        } else {
                            offset = .zero
                        }
                    }
            )
    }
}

struct ParkingDetailsPreview_Previews: PreviewProvider {
    @State static var isShowingPreview = true
    static var previews: some View {
//        ParkingDetailsPreview(parking: ParkingModel.sampleParking, isShowingPreview: $isShowingPreview)
        MapView()
    }
}


// MARK: Views
extension ParkingDetailsPreview {

    private var description: some View {
        VStack(alignment: .leading){
            Text(parking.name)
                .font(.title2)
                .lineLimit(1)
            
            Text(parking.address + ", Poland")
                .font(.caption)
                .foregroundColor(.gray)
            
            VStack(alignment: .leading){
                Text("Available levels: " + parking.level)
                Text("Spots per level: \(parking.quantity)")
                Text("Is guarded: " + (parking.guarded ? "Yes" : "No"))
                Text("Cost per hour: $\(String(format: "%.2f", parking.cost))")
            }
            .padding(.top, 1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var buttons: some View {
        VStack{
            Button {
                withAnimation(.linear(duration: 0.1)) {
                    self.isShowingPreview = false
                }
            } label: {
                Image(systemName: "xmark")
                    .font(.title3)
            }
            
            Spacer()
            
            NavigationLink {
                ParkingDetailsView(parking: parking)
            } label: {
                Image(systemName: "greaterthan")
                    .font(.title3)
            }
          
        }
    }
    
}



// TODO: Co z tym ?
extension ParkingDetailsView {
    func calculateLevels(_ level: String) -> String{
        return ""
    }
}


