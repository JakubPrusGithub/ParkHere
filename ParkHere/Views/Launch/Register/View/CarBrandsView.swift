//
//  CarBrandsView.swift
//  ParkHere
//
//  Created by jabko on 28/03/2023.
//

import SwiftUI

enum CarBrand: String, CaseIterable {
    case AlfaRomeo = "Alfa Romeo"
    case Audi
    case Bentley, BMW
    case Citroën
    case Ferrari, Fiat, Ford
    case Honda, Hyundai
    case Jaguar, Jeep
    case Kia
    case Lamborghini, Lexus
    case Mazda, Mitsubishi
    case MercedesBenz = "Mercedes Bens"
    case Nissan
    case Opel
    case Peugeot, Polonez, Porsche, Renault
    case Seat, Skoda
    case Tesla, Toyota
    case Volkswagen, Volvo
}


struct CarBrandsView: View {
    @Binding var brand: CarBrand
    var body: some View {
        VStack {
            Text("Select the brand of the vehicle")
                .fontWeight(.semibold)
            Picker("", selection: $brand) {
                ForEach(CarBrand.allCases, id: \.self) { brand in
                    Text(brand.rawValue)
                }
            }
            .pickerStyle(.wheel)
        }
    }
}

struct CarBrandsView_Previews: PreviewProvider {
    static var previews: some View {
        CarBrandsView(brand: .constant(.Audi))
    }
}
