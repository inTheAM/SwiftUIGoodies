//
//  ScannerCoordinator.swift
//  Carter
//
//  Created by Ahmed Mgua on 25/06/2022.
//

import AVFoundation

extension CodeScannerView {
    final class ScannerCoordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: CodeScannerView
        var didFinishScanning = false
        var lastScanTime = Date(timeIntervalSince1970: 0)
        
        init(parent: CodeScannerView) {
            self.parent = parent
        }
        
        func reset() {
            didFinishScanning = false
            lastScanTime = Date(timeIntervalSince1970: 0)
        }
        
        
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metadataObject = metadataObjects.first {
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                guard let stringValue = readableObject.stringValue else { return }
                guard didFinishScanning == false else { return }
                let result = ScanResult(string: stringValue, type: readableObject.type)
                if isPastScanInterval() {
                    found(result)
                }
            }
        }
        
        func isPastScanInterval() -> Bool {
            Date().timeIntervalSince(lastScanTime) >= parent.scanInterval
        }
        
        func found(_ result: ScanResult) {
            HapticFeedback.play(.success)
            lastScanTime = Date()
            parent.handler(.success(result))
        }
        
        func didFail(error: ScanError) {
            HapticFeedback.play(.error)
            parent.handler(.failure(error))
        }
    }
}


