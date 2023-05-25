//
//  View+RoundedBorder.swift
//  
//
//  Created by Ahmed Mgua on 24/03/23.
//

import SwiftUI

public enum ShapeType {
    case stroke(lineWidth: CGFloat),
         fill(opacity: CGFloat)
}

extension View {
    public func roundedBorder(systemImage: String? = nil, cornerRadius: Double, color: Color, style: ShapeType) -> some View {
        HStack {
            if let systemImage {
                Image(systemName: systemImage)
                    .foregroundColor(.secondary)
            }
            self
        }
        .padding(.asymmetrical)
        .background {
            switch style {
            case .stroke(let lineWidth):
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: lineWidth)
                    .foregroundColor(color)
            case .fill(let opacity):
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundColor(color.opacity(opacity))
            }

        }
    }
}
