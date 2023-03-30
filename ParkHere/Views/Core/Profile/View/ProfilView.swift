//
//  ProfilView.swift
//  ParkHere
//
//  Created by jabko on 17/03/2023.
//

import SwiftUI

struct ProfilView: View {
    @StateObject private var vm = ProfilViewModel()
    init() { _ = Dependencies() }
    
    var body: some View {
        VStack {
            Spacer() 
            Text("Hello")
            Button("LogOut") {
                do {
                    try vm.singOut()
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            Spacer()
        }
    }
}

struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilView()
    }
}
