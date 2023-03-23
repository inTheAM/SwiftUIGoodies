//
//  LoadingHUD.swift
//  SwiftUIGoodies
//
//  Created by Ahmed Mgua on 04/09/2022.
//

import SwiftUI

internal struct LoadingHUD: View {
    private let label: String = "Loading"
    
    public var body: some View {
        VStack {
            ProgressView()
                .padding()
            Text(label)
                .font(.headline)
        }
        .padding()
        .frame(width: 120, height: 120)
        .cardify(backgroundColor: .primary.opacity(0.2))
        .padding()
    }
}

extension View {
    public func loadingHUD(isPresented: Bool) -> some View {
        self
            .disabled(isPresented)
            .grayscale(isPresented ? 0.5 : 0)
            .overlay {
                if isPresented {
                    LoadingHUD()
                }
            }
    }
}

struct LoadingHUD_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectangle(cornerRadius: 16)
            .foregroundColor(.teal)
            .loadingHUD(isPresented: true)
    }
}
