//
//  View+AsymmetricPadding.swift
//  SwiftUIGoodies
//
//  Created by Ahmed Mgua on 05/08/2022.
//

import SwiftUI

public enum PaddingSymmetry {
    case symmetrical, asymmetrical
}

public extension View {
    func padding(_ symmetry: PaddingSymmetry) -> some View {
        switch symmetry {
        case .symmetrical:
            return self
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
        case .asymmetrical:
            return self
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
        }
    }
}



