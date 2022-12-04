//
//  CodeScannerView.swift
//  Carter
//
//  Created by Ahmed Mgua on 25/06/2022.
//

import AVFoundation
import Combine
import SwiftUI

struct CodeScannerView: UIViewControllerRepresentable {
    let codeTypes: [AVMetadataObject.ObjectType]
    let scanInterval: Double = 2.0
    var isTorchOn: Bool
    var handler: (Result<ScanResult, ScanError>) -> Void
    
    init(
        isTorchOn: Bool = false,
        completion: @escaping (Result<ScanResult, ScanError>) -> Void
    ) {
        let legacyTypes: [AVMetadataObject.ObjectType] = [.ean13, .ean8, .code128, .code39, .itf14, .qr]
        var allTypes = legacyTypes
        if #available(iOS 15.4, *) {
            allTypes.append(contentsOf: [.codabar, .gs1DataBar, .gs1DataBarLimited, .gs1DataBarExpanded])
        }
        
        self.codeTypes = allTypes
        self.isTorchOn = isTorchOn
        self.handler = completion
    }
    
    func makeCoordinator() -> ScannerCoordinator {
        ScannerCoordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> ScannerViewController {
        let viewController = ScannerViewController()
        viewController.delegate = context.coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: ScannerViewController, context: Context) {
        context.coordinator.parent = self
        uiViewController.updateViewController(
            isTorchOn: isTorchOn
        )
    }
    
}
