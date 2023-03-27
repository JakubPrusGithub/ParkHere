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
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}
