//
//  View+Spaced.swift
//  SwiftUIGoodies
//
//  Created by Ahmed Mgua on 07/08/2022.
//

import SwiftUI

struct Spaced: ViewModifier {
    let axis: Axis?
    let alignment: Alignment?
    init(axis: Axis) {
        self.axis = axis
        self.alignment = nil
    }
    init(alignment: Alignment) {
        self.axis = nil
        self.alignment = alignment
    }
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if let axis = axis {
            switch axis {
            case .horizontal:
                HStack {
                    Spacer()
                    content
                    Spacer()
                }
            case .vertical:
                VStack {
                    Spacer()
                    content
                    Spacer()
                }
            }
        } else if let alignment = alignment {
            switch alignment {
            case .leading:
                HStack {
                    Spacer()
                    content
                }
            case .trailing:
                HStack {
                    content
                    Spacer()
                }
            case .top:
                VStack {
                    Spacer()
                    content
                    Spacer()
                }
            case .bottom:
                VStack {
                    content
                    Spacer()
                }
            default:
                content
            }
        }
    }
}

extension View {
    public func spaced(_ axis: Axis) -> some View {
        modifier(Spaced(axis: axis))
    }
    public func spaced(_ alignment: Alignment) -> some View {
        modifier(Spaced(alignment: alignment))
    }
}
