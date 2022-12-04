//
//  ScanResult.swift
//  Carter
//
//  Created by Ahmed Mgua on 25/06/2022.
//

import AVFoundation.AVMetadataObject
import Foundation


public struct ScanResult {
    /// The contents of the scanned code
    public let string: String
    
    /// The type of code that was matched.
    public let type: AVMetadataObject.ObjectType
}
