//
//  View+Header.swift
//  
//
//  Created by Ahmed Mgua on 23/03/23.
//

import SwiftUI

public extension View {
    func header(@ViewBuilder _ content: () -> some View) -> some View {
        Section(header: content()) {
            self
        }
    }

    func header(title: String) -> some View {
        Section(header: SectionHeaderView(title: title)) {
            self
        }
    }
}



