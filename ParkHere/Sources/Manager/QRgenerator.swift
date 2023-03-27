//
//  QRgenerator.swift
//  ParkHere
//
//  Created by Jakub Prus on 27/03/2023.
//

import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins

class QRgenerator: ObservableObject {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    func generateQRCode(from ticket: ParkingTicket) -> UIImage {
        let hashedString = hashTicket(ticket: ticket)
        filter.message = Data(hashedString.utf8)

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    func hashTicket(ticket: ParkingTicket) -> String{
        let originalString = ticket.name + "," + ticket.licenseNumber + "," + ticket.parkingName + "," + ticket.address + "," + ticket.spotNumber + "," + ticket.startDate.formatted() + "," + ticket.endDate.formatted() + "," + String(ticket.price)
        return originalString
    }

}
