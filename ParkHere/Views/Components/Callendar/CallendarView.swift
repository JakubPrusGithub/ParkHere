//
//  CallendarView.swift
//  ParkHere
//
//  Created by Jakub Prus on 21/03/2023.
//

import SwiftUI

struct CallendarView: View {
    
    let parking: ParkingStruct
    @State var dateFrom: Date = .now
    @State var dateTo: Date = .now
    let upToFiveDays: Date = Date().addingTimeInterval(5*24*60*60)
    let today: Date = Date()
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 25){
                
                // MARK: Time interval
                Group{
                    Text("Time interval")
                        .font(.title2)
                        .foregroundColor(.gray)
                    DatePicker("Start date:", selection: $dateFrom, in:today...upToFiveDays)
                    DatePicker("End date:", selection: $dateTo, in:dateFrom...upToFiveDays)
                    HStack{
                        Image(systemName: "info.circle.fill")
                        Text("Please select the beginning and end of your reservation")
                    }
                    .foregroundColor(.gray)
                }
                
                Divider()
                
                // MARK: Cost
                Group{
                    Text("Cost")
                        .font(.title2)
                        .foregroundColor(.gray)
                    Text("Selected time: \(calcTime())")
                    Text("Cost per hour: $\(String(format: "%.2f", parking.cost))")
                    Text("Your estimated cost is: $29.97")
                        .bold()
                }
                
                VStack{
                    NavigationLink("See available spots"){
                        // TODO: parkingSpotsView
                    }
                    .buttonStyle(.sign)
                    .padding(.vertical)
                    Button("Cancel"){
                        // back
                    }
                    .foregroundColor(.gray)
                    .padding(.top, -10)
                }

            }
            .navigationTitle("Reservation date")
            .padding()
            .foregroundColor(.customGrey)
            .onAppear{
                if dateTo == dateFrom {
                    print("takie samo")
                }
            }
        }
    }
}

extension CallendarView{
    func calcTime() -> String {
        var seconds = Int(dateTo - dateFrom)
        if seconds < 0 { seconds = 0 }
        return "\(seconds/60/60) hours"
    }
}

struct CallendarView_Previews: PreviewProvider {
    static var previews: some View {
        CallendarView(parking: .sampleParking)
    }
}
