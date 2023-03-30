//
//  SpotSelection.swift
//  ParkHere
//
//  Created by Jakub Prus on 30/03/2023.
//

import SwiftUI

struct SpotSelection: View {
    
    @State var allParkingSpots: Int
    @Binding var allFreeSpots: [Int]
    @Binding var selectedSpot: Int
    @State var evenSpots = [Int]()
    @State var oddSpots = [Int]()
    
    
    var body: some View {
        ZStack{
            Image("myCar")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .padding(.top, -150)
            ScrollView(.vertical){
                HStack(spacing: 120){
                    
                    VStack{ // MARK: ODD
                        ForEach(oddSpots, id:\.self) { slot in
                            Button(){
                                selectedSpot = slot
                            }label: {
                                ZStack{
                                    Image(allFreeSpots.contains(slot) ? "freeSpotLeft" : "takenSpotLeft")
                                        .resizable()
                                        .scaledToFit()
                                    Text(slot.description)
                                        .bold()
                                        .font(.title2)
                                    
                                }
                                .background{
                                    Color(allFreeSpots.contains(slot) ? .green : .red)
                                        .opacity(0.7)
                                    if slot == selectedSpot{
                                        Color.blue
                                    }
                                }
                            }
                            .disabled(allFreeSpots.contains(slot) ? false : true)
                            .foregroundColor(.black)
                            .frame(width: 125, height: 125)
                            .padding(.vertical, -25)
                        }
                    } // Odd
                    
                    VStack{ // MARK: EVEN
                        ForEach(evenSpots, id:\.self) { slot in
                            Button(){
                                selectedSpot = slot
                            }label: {
                                ZStack{
                                    Image(allFreeSpots.contains(slot) ? "freeSpotRight" : "takenSpotRight")
                                        .resizable()
                                        .scaledToFit()
                                        
                                    Text(slot.description)
                                        .bold()
                                        .font(.title2)
                                }
                                .background{
                                    Color(allFreeSpots.contains(slot) ? .green : .red)
                                        .opacity(0.75)
                                    if slot == selectedSpot{
                                        Color.blue
                                    }
                                }
                            }
                            .disabled(allFreeSpots.contains(slot) ? false : true)
                            .foregroundColor(.black)
                            .frame(width: 125, height: 125)
                            .padding(.vertical, -25)
                        }
                    }// Even
                    
                }// HStack
                .padding(.vertical, 8)
                
            }// ScrollView
            
        }// ZStack
        .border(.black)
        .onAppear{
            evenSpots = Array(1...allParkingSpots).filter{$0.isMultiple(of: 2)}
            oddSpots = Array(1...allParkingSpots).filter{$0 % 2 == 1}
            UIScrollView.appearance().bounces = false
        }
        .background{
            Color.customGrey.opacity(0.75)
        }
    }
}

struct SpotSelection_Previews: PreviewProvider {
    @State static var allFreeSpots = [1,2,4,5,8,9,11]
    @State static var selectedSpot = 1
    static var previews: some View {
        SpotSelection(allParkingSpots: 100, allFreeSpots: $allFreeSpots, selectedSpot: $selectedSpot)
    }
}
