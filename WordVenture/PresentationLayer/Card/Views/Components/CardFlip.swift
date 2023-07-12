//
//  CardFlip.swift
//  WordVenture
//
//  Created by Yu Takahashi on 7/7/23.
//

import SwiftUI
import SwiftUIPager

struct CardFlip: ViewModifier {
    @EnvironmentObject private var wordController: WordsController
    @EnvironmentObject private var page: Page
    
    @State private var flipped = false
    
    private let id: UUID
    private let insets: EdgeInsets
    private let back: any View
    
    init(id: UUID, insets: EdgeInsets, @ViewBuilder back: () -> any View) {
        self.id = id
        self.insets = insets
        self.back = back()
    }
    
    func body(content: Content) -> some View {
        let flipDegrees = flipped ? 180.0 : 0
        
        ZStack {
            content
                .placedOnCard(insets: insets)
                .flipRotate(flipDegrees)
                .opacity(flipped ? 0.0 : 1.0)
            
            AnyView(back)
                .placedOnCard(insets: insets)
                .flipRotate(-180 + flipDegrees)
                .opacity(flipped ? 1.0 : 0.0)
        }
        .animation(.spring(response: 0.8, dampingFraction: 0.6), value: flipped)
        .onTapGesture {
            if wordController.wordbook.words[page.index].id == id {
                flipped.toggle()
            }
        }
        .onChange(of: flipped) { _ in
            feedbackGenerator(style: .medium)
        }
    }
}

extension View {
    @MainActor func cardFlip(id: UUID, insets: EdgeInsets, @ViewBuilder back: () -> any View) -> some View {
        modifier(CardFlip(id: id, insets: insets, back: back))
    }
    
    func flipRotate(_ degrees : Double) -> some View {
        return self
            .rotation3DEffect(Angle(degrees: degrees), axis: (x: 0.0, y: 1.0, z: 0.0))
    }
    
    func placedOnCard(insets: EdgeInsets) -> some View {
        return self
            .padding(5)
            .frame(maxHeight: .infinity)
            .background(Color(.systemFill))
            .cornerRadius(20)
            .padding(.vertical, 40)
            .shadow(color: .black.opacity(0.2), radius: 15)
            .padding(.top, insets.top + 30)
            .padding(.bottom, insets.bottom)
    }
}
