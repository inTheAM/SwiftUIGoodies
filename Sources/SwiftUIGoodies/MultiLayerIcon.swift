//
//  MultilayerIcon.swift
//  SwiftUIGoodies
//
//  Created by Ahmed Mgua on 18/08/2022.
//

import SwiftUI

public struct MultiLayerIcon: View {
    public init(baseSystemImage: (name: String, font: Font), overlaySystemImage: (name: String, font: Font, alignment: Alignment)) {
        self.baseSystemImage = baseSystemImage
        self.overlaySystemImage = overlaySystemImage
    }
    
    let baseSystemImage: (name: String, font: Font)
    let overlaySystemImage: (name: String, font: Font, alignment: Alignment)
    
    public var body: some View {
        Image(systemName: baseSystemImage.name)
            .symbolRenderingMode(.multicolor)
            .font(baseSystemImage.font)
            .foregroundColor(.primary)
            .overlay(alignment: overlaySystemImage.alignment) {
                Image(systemName: overlaySystemImage.name)
                    .font(overlaySystemImage.font)
                    .background(Color.white.clipShape(Circle()))
            }
            .spaced(.horizontal)
            .padding(.asymmetrical)
    }
}

public struct LabeledNavigationView<Destination: View>: View {
    private let destination: Destination
    private let label: (name: String, font: Font)
    private let baseSystemImage: (name: String, font: Font)
    private let overlaySystemImage: (name: String, font: Font, alignment: Alignment)
    
    public init(destination: Destination, label: (name: String, font: Font), baseSystemImage: (name: String, font: Font), overlaySystemImage: (name: String, font: Font, alignment: Alignment)) {
        self.destination = destination
        self.label = label
        self.baseSystemImage = baseSystemImage
        self.overlaySystemImage = overlaySystemImage
    }
    public var body: some View {
        NavigationLink(destination: destination) {
            VStack {
                MultiLayerIcon(baseSystemImage: baseSystemImage,
                               overlaySystemImage: overlaySystemImage)
                
                Text(label.name)
                    .font(label.font)
            }
            .padding(.asymmetrical)
            .cardified()
        }
    }
}

public struct LabeledButton: View {
    private let label: (name: String, font: Font)
    private let systemImage: (name: String, font: Font)
    private let action: () -> ()
    public init(label: (name: String, font: Font), systemImage: (name: String, font: Font), _ action: @escaping () -> ()) {
        self.label = label
        self.systemImage = systemImage
        self.action = action
    }
    public var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: systemImage.name)
                    .font(systemImage.font)
                    .padding(.horizontal)
                
                Text(label.name)
                    .font(label.font)
            }
        }
        .buttonStyle(.bordered)
    }
}
