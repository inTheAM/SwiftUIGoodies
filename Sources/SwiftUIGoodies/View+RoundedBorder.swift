//
//  View+RoundedBorder.swift
//  
//
//  Created by Ahmed Mgua on 24/03/23.
//

import SwiftUI

extension View {
    func roundedBorder(icon: String? = nil, cornerRadius: Double) -> some View {
        HStack {
            if let icon {
                Image(systemName: icon)
                    .foregroundColor(.secondary)
            }
            self
        }
        .padding(8)
        .background {
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(lineWidth: 1)
                .foregroundColor(.secondary)
        }
    }
}
