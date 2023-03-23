//
//  SectionHeaderView.swift
//  SwiftUIGoodies
//
//  Created by Ahmed Mgua on 18/08/2022.
//

import SwiftUI

internal struct SectionHeaderView: View {
    init(title: String) {
        self.title = title
    }
    
    private let title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.title2.bold())
                .foregroundColor(.primary)
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

struct SectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SectionHeaderView(title: "Header")
    }
}
