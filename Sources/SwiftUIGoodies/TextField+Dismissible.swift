//
//  TextField+Dismissible.swift
//  
//
//  Created by Ahmed Mgua on 25/05/23.
//

import SwiftUI

public extension TextField {
    func dismissible(focusState: FocusState<Bool>.Binding) -> some View {
        self
            .focused(focusState)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            focusState.wrappedValue = false
                        }
                        .font(.headline)

                }
            }
    }
}
