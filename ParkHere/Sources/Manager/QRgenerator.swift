//
//  QRgenerator.swift
//  ParkHere
//
//  Created by Jakub Prus on 27/03/2023.
//

import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins
//import CryptoKit

class QRgenerator: ObservableObject {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    //var hashedTicketString = ""
    
    func generateQRCode(ticket: ParkingTicket) -> UIImage{
        let originalString = ticket.name + ", " + ticket.licenseNumber + ", " + ticket.parkingName + ", " + ticket.address + ", " + ticket.spotNumber + ", " + ticket.startDate.formatted() + ", " + ticket.endDate.formatted() + ", " + String(ticket.price) + ", " + ticket.id!
//        let ticketData = originalString.data(using: .utf8)!
//        let symmetricKey = CryptoKit.SymmetricKey.init(size: .bits128)
//        let encryptedSealedBox = try! AES.GCM.seal(ticketData, using: SymmetricKey(data: symmetricKey))
//        hashedTicketString = encryptedSealedBox.ciphertext.base64EncodedString()
//        filter.message = Data(hashedTicketString.utf8)
        filter.message = Data(originalString.utf8)

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}
