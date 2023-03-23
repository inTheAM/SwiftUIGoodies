//
//  StripedList.swift
//  SwiftUIGoodies
//
//  Created by Ahmed Mgua on 19/08/2022.
//

import SwiftUI
import UIKit

public struct StripedList<Content: View, Item: Hashable>: View {
    public init(items: [Item],
                stripeColor: Color = .primary,
                @ViewBuilder _ content: @escaping (Item) -> Content
    ) {
        self.items = items
        self.stripeColor = stripeColor
        self.content = content
    }
    public init(items: [Item],
                stripeColor: Color = .primary,
                @ViewBuilder content: @escaping (Item) -> Content,
                onDelete: @escaping (IndexSet) -> ()
    ) {
        self.content = content
        self.stripeColor = stripeColor
        self.items = items
        self.onDelete = onDelete
    }
    
    var stripeColor: Color
    var content: (Item) -> Content
    var items: [Item]
    var onDelete: (IndexSet) -> () = { _ in }
    
    public var body: some View {
        List {
            ForEach(items.indices, id: \.self) { index in
                let item = items[index]
                content(item)
                    .listRowBackground(index.isMultiple(of: 2) ? stripeColor.opacity(0.1) : .clear)
            }
            .onDelete(perform: onDelete)
        }
        .listStyle(.plain)
    }
}

public extension StripedList {
    func header(@ViewBuilder _ content: @escaping () -> some View) -> some View {
        Section(header: content()) {
            self
        }
    }
}



extension UIViewController {
    var topmostPresentedViewController: UIViewController {
        presentedViewController?.topmostPresentedViewController ?? self
    }
    
    var topmostViewController: UIViewController? {
        if let controller = (self as? UINavigationController)?.visibleViewController {
            return controller.topmostViewController
        } else if let controller = (self as? UITabBarController)?.selectedViewController {
            return controller.topmostViewController
        } else if let controller = presentedViewController {
            return controller.topmostViewController
        } else {
            return self
        }
    }
    
    var topmostPresentingViewController: UIViewController? {
        topmostViewController?.presentingViewController
    }
}

struct TopMostView: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        UIViewController().topmostPresentedViewController
    }
}
