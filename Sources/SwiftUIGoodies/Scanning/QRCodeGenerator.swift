//
//  QRCodeGenerator.swift
//  SwiftUIGoodies
//
//  Created by Ahmed Mgua on 10/08/2022.
//

import CoreImage.CIFilterBuiltins
import UIKit

public struct QRCodeGenerator {
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
    
    func generateQRCode(from string: String) throws -> UIImage {
        filter.message = Data(string.utf8)
        
        guard let outputImage = filter.outputImage,
              let cgimg = context.createCGImage(outputImage, from: outputImage.extent)
        else {
            throw QRError.failedToCreateImage
        }
        return UIImage(cgImage: cgimg)
    }
}

public enum QRError: Error {
    case failedToCreateImage
}
