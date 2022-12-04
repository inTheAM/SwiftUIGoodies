//
//  Carousel.swift
//  SwiftUIGoodies
//
//  Created by Ahmed Mgua on 04/09/2022.
//

import SwiftUI

public struct Carousel<Content:View, Item: Hashable>:View {
    @GestureState private var offset: CGFloat = 0
    @State private var currentIndex = 0
    var content: (Item)-> Content
    var items: [(Int, Item)]
    let spacing: CGFloat
    let trailingSpace: CGFloat
    let cardWidth: CGFloat
    public init(_ items: [Item], spacing: CGFloat = 16, trailingSpace: CGFloat = 100, @ViewBuilder content: @escaping (Item) -> Content) {
        self.items = items.enumerated().map { index, item in
            (index, item)
        }
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self.content = content
        self.cardWidth = UIScreen.main.bounds.width - trailingSpace - spacing
    }
    
    public var body: some View {
        GeometryReader { geometry in
            LazyHStack(spacing: spacing) {
                ForEach(items, id: \.0) { index, item in
                    content(item)
                        .frame(width: cardWidth, height: height(index: index))
                        .rotation3DEffect(.degrees(angle(index: index)),
                                          axis: (x: 0, y: 1, z: 0)
                        )
                }
            }
            .offset(x: offset + (-(cardWidth + spacing) * CGFloat(currentIndex)))
            .padding(.horizontal,  (UIScreen.main.bounds.width - cardWidth)/2 )
            .padding(.vertical)
            .gesture(
                DragGesture()
                    .updating($offset) { value, offset, _ in
                        offset = value.translation.width
                    }
                    .onEnded { value in
                        let offset = value.translation.width
                        let progress = -offset / UIScreen.main.bounds.width
                        let roundedIndex = progress.rounded()
                        let minRange = min(currentIndex + Int(roundedIndex), items.count - 1)
                        self.currentIndex = max(minRange, 0)
                        let impactMed = UIImpactFeedbackGenerator(style: .light)
                        impactMed.impactOccurred()
                    }
            )
            .animation(.default, value: offset)
        }
        
    }
    
    private func angle(index: Int) -> Double {
        if index < currentIndex {
            return -15
        }
        if index > currentIndex {
            return 15
        }
        return 0
    }
    
    private func height(index: Int) -> Double {
        index == currentIndex ?  500 :  450
    }
}

struct Carousel_Previews: PreviewProvider {
    static var previews: some View {
        Carousel([0,1]) { _ in
            Color.blue
        }
    }
}
