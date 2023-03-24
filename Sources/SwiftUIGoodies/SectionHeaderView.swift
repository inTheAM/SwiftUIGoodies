//
//  SectionHeaderView.swift
//  SwiftUIGoodies
//
//  Created by Ahmed Mgua on 18/08/2022.
//

import SwiftUI

internal struct SectionHeaderView: View {
    init(title: String, background color: Color? = nil) {
        self.title = title
        self.backgroundColor = color
    }
    
    private let title: String
    private let backgroundColor: Color?
    var body: some View {
        HStack {
            Text(title)
                .font(.title2.bold())
                .foregroundColor(.primary)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background {
            if let backgroundColor {
                backgroundColor.opacity(0.2)
                    .background(Color.primary.colorInvert())
            }
        }
    }
}

struct SectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SectionHeaderView(title: "Header")
    }
}
