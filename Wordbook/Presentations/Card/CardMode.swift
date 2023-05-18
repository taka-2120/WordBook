//
//  CardMode.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/10/10.
//

import SwiftUI

struct CardMode: View {
    @EnvironmentObject private var controller: WordsController
    @State private var isCardModeShown = false
    
    var body: some View {
        TabView {
            ForEach(Array(controller.wordbook.words.enumerated()), id: \.offset) { index, word in
                Text(word.original)
                    .cardFlip {
                        Text(word.translated)
                    }
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isCardModeShown) {
            CardIntroductionView()
        }
        .onAppear {
            let isCardModeOpened = UserDefaults.standard.bool(forKey: isCardModeOpenedKey)
            
            if !isCardModeOpened {
                isCardModeShown = true
                UserDefaults.standard.set(true, forKey: isCardModeOpenedKey)
            }
        }
    }
}

struct CardFlip: ViewModifier {
    @State var flipped = false
    var back: any View
    
    init(@ViewBuilder back: () -> any View) {
        self.back = back()
    }
    
    func body(content: Content) -> some View {
        let flipDegrees = flipped ? 180.0 : 0
        
        ZStack {
            content
                .placedOnCard()
                .flipRotate(flipDegrees)
                .opacity(flipped ? 0.0 : 1.0)
            AnyView(back)
                .placedOnCard()
                .flipRotate(-180 + flipDegrees)
                .opacity(flipped ? 1.0 : 0.0)
        }
        .animation(.easeInOut(duration: 0.8), value: flipped)
        .onTapGesture {
            flipped.toggle()
        }
    }
}

extension View {
    func cardFlip(@ViewBuilder back: () -> any View) -> some View {
        modifier(CardFlip(back: back))
    }
    
    func flipRotate(_ degrees : Double) -> some View {
        return self
            .rotation3DEffect(Angle(degrees: degrees), axis: (x: 0.0, y: 1.0, z: 0.0))
    }
    
    func placedOnCard() -> some View {
        return self
            .padding(5)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(Color(.systemBackground))
            .cornerRadius(20)
            .padding(30)
            .shadow(color: .black.opacity(0.2), radius: 15)
    }
}
