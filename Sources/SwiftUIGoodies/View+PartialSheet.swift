//
//  View+PartialSheet.swift
//  Carter
//
//  Created by Ahmed Mgua on 25/06/2022.
//

import SwiftUI

public extension View {
    func partialSheet<Content: View, Item>(title: String, item: Binding<Item?>, @ViewBuilder _ content: ( Binding<Item?>) -> Content) -> some View
    where Item: Identifiable & Equatable {
        self
            .overlay {
                if item.wrappedValue != nil {
                    BlurView(style: .dark)
                        .edgesIgnoringSafeArea(.all)
                        .opacity(0.6)
                        .overlay {
                            VStack {
                                Spacer()
                                    VStack {
                                        HStack {
                                            Text(title)
                                                .font(.system(.title2))
                                                .fontWeight(.heavy)
                                                .foregroundColor(.primary)
                                                .multilineTextAlignment(.leading)
                                            
                                            Spacer()
                                            Button(action: {
                                                item.wrappedValue = nil
                                            }) {
                                                Color.primary
                                                    .clipShape(Circle())
                                                    .frame(width: 30, height: 30, alignment: .center)
                                                    .overlay {
                                                        Image(systemName: "xmark")
                                                            .font(Font.callout.weight(.bold))
                                                            .foregroundColor(Color(UIColor.systemBackground))
                                                    }
                                                
                                            }
                                        }
                                        
                                        content(item)
                                        
                                    }
                                    .padding()
                                    .background(
                                        BlurView(style: .regular)
                                            .cornerRadius(32)
                                            .edgesIgnoringSafeArea(.all)
                                    )
                                
                            }
                            
                        }
                        .transition(.move(edge: .bottom))
                        .animation(.default, value: item.wrappedValue)
                }
            }
        
    }
    
    func partialSheet<Content: View>(title: String, isPresented: Binding<Bool>, @ViewBuilder _ content: () -> Content) -> some View {
        self
            .overlay {
                if isPresented.wrappedValue {
                    BlurView(style: .dark)
                        .edgesIgnoringSafeArea(.all)
                        .opacity(0.6)
                        .overlay {
                            VStack {
                                Spacer()
                                    VStack {
                                        HStack {
                                            Text(title)
                                                .font(.system(.title2))
                                                .fontWeight(.bold)
                                                .foregroundColor(.primary)
                                                .multilineTextAlignment(.leading)
                                            
                                            Spacer()
                                            Button(action: {
                                                isPresented.wrappedValue = false
                                            }) {
                                                Color.primary
                                                    .clipShape(Circle())
                                                    .frame(width: 30, height: 30, alignment: .center)
                                                    .overlay {
                                                        Image(systemName: "xmark")
                                                            .font(Font.callout.weight(.bold))
                                                            .foregroundColor(Color(UIColor.systemBackground))
                                                    }
                                                
                                            }
                                        }
                                        
                                        content()
                                        
                                    }
                                    .padding()
                                    .background(
                                        BlurView(style: .regular)
                                            .cornerRadius(32)
                                            .edgesIgnoringSafeArea(.all)
                                    )
                                
                            }
                            
                        }
                        .transition(.move(edge: .bottom))
                        .animation(.default, value: isPresented.wrappedValue)
                }
            }
        
    }
}
