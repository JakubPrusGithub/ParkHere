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
        ZStack{
            BackgroundPreview()
            HStack{
                VStack(alignment: .leading){
                    HStack{
                        Text(parking.name)
                            .font(.title2)
                            .lineLimit(1)
                        Spacer()
                    }
                    Text(parking.address + ", Poland")
                        .font(.caption)
                        .foregroundColor(.gray)
                    VStack(alignment: .leading){
                        Text("Available levels: " + parking.level)
                        Text("Spots per level: \(parking.quantity)")
                        Text("Is guarded: " + (parking.guarded ? "Yes" : "No"))
                        Text("Cost per hour: $\(String(format: "%.2f", parking.cost))")
                        //Text(parking.description)
                    }
                    .padding(.top, 1)
                }
                .padding(20)
                VStack{
                    Button{
                        withAnimation(.linear(duration: 0.1)) {
                            self.isShowingPreview = false
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title3)
                    }
                    Spacer()
                    Button{
                        // TODO: present detail view with parking info
                        ParkingDetailsView(parking: parking)
                    } label: {
                        Image(systemName: "greaterthan")
                            .font(.title3)
                    }
                }
                .padding(25)
            }
        } //ZStack
        .frame(height: 175)
        .foregroundColor(.customGrey)
        .offset(x: 0, y: offset.height)
        .opacity(2 - Double(abs(offset.height / 50)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
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

extension ParkingDetailsView {
    func calculateLevels(_ level: String) -> String{
        return ""
    }
}

struct BackgroundPreview: View{
    var body: some View{
        Rectangle()
            .foregroundColor(.white)
            .background(Color.white)
            .cornerRadius(10)
            .background(
                Color.white
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 6, x: 0, y: 2)
                    .blur(radius: 10)
            )
    }
}

struct ParkingDetailsPreview_Previews: PreviewProvider {
    @State static var isShowingPreview = true
    static var previews: some View {
        ParkingDetailsPreview(parking: ParkingStruct.sampleParking, isShowingPreview: $isShowingPreview)
    }
}
