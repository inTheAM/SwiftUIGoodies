//
//  SectionHeaderView.swift
//  SwiftUIGoodies
//
//  Created by Ahmed Mgua on 18/08/2022.
//

import SwiftUI

public struct SectionHeaderView: View {
    public init(title: String) {
        self.title = title
    }
    
    let title: String
    public var body: some View {
        HStack {
            Text(title)
                .font(.title2.bold())
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(
            Color.primary.opacity(0.2)
                .background(Color.primary.colorInvert())
        )
    }
}
