//
//  View+Cardify.swift
//  SwiftUIGoodies
//
//  Created by Ahmed Mgua on 05/08/2022.
//

import SwiftUI

public extension View {
    func cardify()    ->    some View {
        return self
            .background(Color(UIColor.systemBackground).overlay(Color.white.opacity(0.2)))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.1), radius: 3)
    }
    
    func cardify(backgroundColor: Color = .systemBackground) -> some View {
        self
            .background(
                backgroundColor
                    .cornerRadius(16)
            )
    }
}

public extension TextField {
    func doneButton(_ focusStateAction: @escaping () ->()) -> some View {
        self
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    HStack {
                        Spacer()
                        Button("Done") {
                            focusStateAction()
                        }
                        .font(.headline)
                    }
                }
            }
    }
    
    var doneButton: some ToolbarContent {
        ToolbarItemGroup(placement: .keyboard) {
            HStack {
                Spacer()
                Button("Done") {}
            }
        }
    }
}
