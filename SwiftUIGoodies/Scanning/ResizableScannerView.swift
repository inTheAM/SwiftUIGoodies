//
//  ResizableScannerView.swift
//  Carter
//
//  Created by Ahmed Mgua on 27/06/2022.
//

import SwiftUI


public struct ResizableScannerView: View {
    public init(isExpanded: Binding<Bool>, resultHandler: @escaping (Result<ScanResult, ScanError>) -> ()) {
        self._isExpanded = isExpanded
        self.resultHandler = resultHandler
    }
    
    @Namespace var namespace
    @Binding var isExpanded: Bool
    let resultHandler: (Result<ScanResult, ScanError>) -> ()
    public var body: some View {
        
        Group {
            if isExpanded {
                CodeScannerView() { result in
                    resultHandler(result)
                }
                .ignoresSafeArea()
                .matchedGeometryEffect(id: "scanner", in: namespace)
            } else {
                Rectangle()
                    .foregroundColor(.black)
                    .matchedGeometryEffect(id: "scanner", in: namespace)
            }
        }
        .overlay {
            Button(action: {
                isExpanded.toggle()
            }) {
                Image(systemName: "barcode.viewfinder")
                    .resizable()
                    .font(Font.title.weight(.ultraLight))
                    .foregroundColor(isExpanded ? .yellow.opacity(isExpanded ? 1 : 0.5) : .gray.opacity(isExpanded ? 1 : 0.5))
                    .frame(width: 40, height: 40)
                    .overlay {
                        if !isExpanded {
                            Rectangle()
                                .foregroundColor(.gray)
                                .frame(width: 60, height: 2)
                                .rotationEffect(Angle(degrees: -45))
                        }
                    }
                    .matchedGeometryEffect(id: "viewfinder", in: namespace)
            }
        }
        .frame(height: isExpanded ? 180 : 60)
        
    }
    
}


