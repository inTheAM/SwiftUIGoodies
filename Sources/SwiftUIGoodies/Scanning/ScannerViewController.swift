//
//  ScannerViewController.swift
//  Carter
//
//  Created by Ahmed Mgua on 25/06/2022.
//
//startRunning may not be called between calls to beginConfiguration and commitConfiguration'
import AVFoundation
import SwiftUI

extension CodeScannerView {
    final class ScannerViewController: UIViewController, UINavigationControllerDelegate {
        
        var delegate: CodeScannerView.ScannerCoordinator?
        
        var captureSession: AVCaptureSession!
        var previewLayer: AVCaptureVideoPreviewLayer!
        let videoCaptureDevice = AVCaptureDevice.default(for: .video)
        
        private lazy var viewFinder: UIImageView? = {
            guard let image = UIImage(systemName: "viewfinder") else {
                return nil
            }
            
            let imageView = UIImageView(image: image)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        override  func viewDidLoad() {
            super.viewDidLoad()
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(updateOrientation),
                                                   name: Notification.Name("UIDeviceOrientationDidChangeNotification"),
                                                   object: nil)
            
            view.backgroundColor = UIColor.black
            captureSession = AVCaptureSession()
            
            guard let videoCaptureDevice = videoCaptureDevice else {
                return
            }
            
            
            AVCaptureDevice.requestAccess(for: .video) { _ in
                
                DispatchQueue.main.async {
                    self.setNeedsStatusBarAppearanceUpdate()
                }
                
                let videoInput: AVCaptureDeviceInput
                
                do {
                    videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
                } catch {
                    self.delegate?.didFail(error: .initError(error))
                    return
                }
                
                if (self.captureSession.canAddInput(videoInput)) {
                    self.captureSession.addInput(videoInput)
                } else {
                    self.delegate?.didFail(error: .badInput)
                    return
                }
                
                let metadataOutput = AVCaptureMetadataOutput()
                
                if (self.captureSession.canAddOutput(metadataOutput)) {
                    self.captureSession.addOutput(metadataOutput)
                    
                    metadataOutput.setMetadataObjectsDelegate(self.delegate, queue: DispatchQueue.main)
                    metadataOutput.metadataObjectTypes = self.delegate?.parent.codeTypes
                } else {
                    self.delegate?.didFail(error: .badOutput)
                    return
                }
            }
        }
        
        override  func viewWillLayoutSubviews() {
            previewLayer?.frame = view.layer.bounds
        }
        
        @objc func updateOrientation() {
            guard let orientation = view.window?.windowScene?.interfaceOrientation else { return }
            guard let connection = captureSession.connections.last, connection.isVideoOrientationSupported else { return }
            connection.videoOrientation = AVCaptureVideoOrientation(rawValue: orientation.rawValue) ?? .portrait
        }
        
        override  func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            updateOrientation()
        }
        
        override  func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            if previewLayer == nil {
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            }
            
            previewLayer.frame = view.layer.bounds
            previewLayer.videoGravity = .resizeAspectFill
            view.layer.addSublayer(previewLayer)
            
            delegate?.reset()
            
            if (captureSession?.isRunning == false) {
                DispatchQueue.global(qos: .userInitiated).async {
                    self.captureSession.startRunning()
                }
            }
        }
        
        override  func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            
            if (captureSession?.isRunning == true) {
                DispatchQueue.global(qos: .userInitiated).async {
                    self.captureSession.stopRunning()
                }
            }
            
            NotificationCenter.default.removeObserver(self)
        }
        
        override  var prefersStatusBarHidden: Bool {
            true
        }
        
        override  var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            .all
        }
        
        /** Touch the screen for autofocus */
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard touches.first?.view == view,
                  let touchPoint = touches.first,
                  let device = videoCaptureDevice,
                  device.isFocusPointOfInterestSupported
            else { return }
            
            let videoView = view
            let screenSize = videoView!.bounds.size
            let xPoint = touchPoint.location(in: videoView).y / screenSize.height
            let yPoint = 1.0 - touchPoint.location(in: videoView).x / screenSize.width
            let focusPoint = CGPoint(x: xPoint, y: yPoint)
            
            do {
                try device.lockForConfiguration()
            } catch {
                return
            }
            
            // Focus to the correct point, make continuous focus and exposure so the point stays sharp when moving the device closer
            device.focusPointOfInterest = focusPoint
            device.focusMode = .continuousAutoFocus
            device.exposurePointOfInterest = focusPoint
            device.exposureMode = AVCaptureDevice.ExposureMode.continuousAutoExposure
            device.unlockForConfiguration()
        }
        
        
        func updateViewController(isTorchOn: Bool) {
            if let backCamera = AVCaptureDevice.default(for: AVMediaType.video),
               backCamera.hasTorch {
                try? backCamera.lockForConfiguration()
                backCamera.torchMode = isTorchOn ? .on : .off
                backCamera.unlockForConfiguration()
            }
        }
        
    }
    
}
