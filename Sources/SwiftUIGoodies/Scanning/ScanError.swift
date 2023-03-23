//
//  ScanError.swift
//  Carter
//
//  Created by Ahmed Mgua on 25/06/2022.
//

import Foundation

public enum ScanError: Error {
    /// The camera could not be accessed.
    case badInput
    
    /// The camera was not capable of scanning the requested codes.
    case badOutput
    
    /// Initialization failed.
    case initError(_ error: Error)
}
