//
//  SpotSelection.swift
//  ParkHere
//
//  Created by Jakub Prus on 30/03/2023.
//

import SwiftUI

struct SpotSelection: View {
    @EnvironmentObject var vm: ReservationViewModel
    @State var evenSpots = [Int]()
    @State var oddSpots = [Int]()
    
    init() { _ = Dependencies() }
    
    var body: some View {
        ScrollView(.vertical){
            HStack(spacing: 120){
                oddSpotsView
                
                evenSpotsView
            }
        }
        .overlay { myCar }
        .border(.black)
        .background{ Color.customGrey.opacity(0.75) }
        .onAppear{
            evenSpots = Array(1...vm.parking.quantity).filter{$0.isMultiple(of: 2)}
            oddSpots = Array(1...vm.parking.quantity).filter{$0 % 2 == 1}
            UIScrollView.appearance().bounces = false
        }
    }
}

struct SpotSelection_Previews: PreviewProvider {
    static var previews: some View {
        ReservationView(parking: .sampleParking)
    }
}



// MARK: View Components
extension SpotSelection {
    
    private var myCar: some View {
        Image("myCar")
            .resizable()
            .scaledToFit()
            .frame(width: 80, height: 80)
            .padding(.top, -150)
    }
    
    private var oddSpotsView: some View {
        VStack{
            ForEach(oddSpots, id:\.self) { slot in
                
                Button(){ vm.selectedSpot = slot }
                label: { parkingSpots(slot: slot) }
                
                .disabled(vm.quantity.contains(slot) ? false : true)
                .foregroundColor(.black)
                .frame(width: 125, height: 125)
                .padding(.vertical, -25)
            }
        }
    }
    
    private var evenSpotsView: some View {
        VStack{
            ForEach(evenSpots, id:\.self) { slot in
                
                Button() { vm.selectedSpot = slot }
                label: { parkingSpots(slot: slot) }
                
                .disabled(vm.quantity.contains(slot) ? false : true)
                .foregroundColor(.black)
                .frame(width: 125, height: 125)
                .padding(.vertical, -25)
            }
        }
    }
}

// MARK: Function -> some View
extension SpotSelection {
    
    private func parkingSpots(slot: Int) -> some View {
        ZStack{
            Image(vm.quantity.contains(slot) ? "freeSpotRight" : "takenSpotRight")
                .resizable()
                .scaledToFit()
                
            Text(slot.description)
                .bold()
                .font(.title2)
        }
        .background{
            Color(vm.quantity.contains(slot) ? .green : .red)
                .opacity(0.75)
            if slot == vm.selectedSpot {
                Color.blue
            }
        }
    }
}
