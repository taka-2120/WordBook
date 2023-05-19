//
//  CardMode.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/10/10.
//

import SwiftUI
import SwiftUIPager

struct CardMode: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject private var controller: WordsController
    
    @StateObject var page: Page = .first()
    @State private var isCardModeShown = false
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                Pager(page: page,
                      data: controller.wordbook.words,
                      id: \.id) { word in
                    Text(word.original)
                        .font(.title)
                        .fontWeight(.bold)
                        .cardFlip(insets: geo.safeAreaInsets) {
                            Text(word.translated)
                                .font(.title)
                                .fontWeight(.bold)
                        }
                }
                .interactive(scale: 0.8)
                .edgesIgnoringSafeArea(.all)
                .background(Color(.systemGroupedBackground))
                .onAppear {
                    print(geo.safeAreaInsets)
                    let isCardModeOpened = UserDefaults.standard.bool(forKey: isCardModeOpenedKey)
                    
                    if !isCardModeOpened {
                        isCardModeShown = true
                        UserDefaults.standard.set(true, forKey: isCardModeOpenedKey)
                    }
                }
            }
            
            VStack(alignment: .trailing) {
                Button {
                    dismiss()
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color(white: colorScheme == .light ? 0.19 : 0.93))
                        Image(systemName: "xmark").resizable()
                            .scaledToFit()
                            .font(Font.body.weight(.bold))
                            .scaleEffect(0.416)
                            .foregroundColor(Color(white: colorScheme == .light ? 0.62 : 0.51))
                    }
                    .frame(width: 30, height: 30)
                }
                .padding(.trailing)

                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
        }
        .toolbar(.hidden, for: .navigationBar)
        .sheet(isPresented: $isCardModeShown) {
            CardIntroductionView()
        }
//        .onAppear {
//            let isCardModeOpened = UserDefaults.standard.bool(forKey: isCardModeOpenedKey)
//
//            if !isCardModeOpened {
//                isCardModeShown = true
//                UserDefaults.standard.set(true, forKey: isCardModeOpenedKey)
//            }
//        }
    }
}

struct CardFlip: ViewModifier {
    @State var flipped = false
    var insets: EdgeInsets
    var back: any View
    
    init(insets: EdgeInsets, @ViewBuilder back: () -> any View) {
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
            flipped.toggle()
        }
    }
}

extension View {
    func cardFlip(insets: EdgeInsets, @ViewBuilder back: () -> any View) -> some View {
        modifier(CardFlip(insets: insets, back: back))
    }
    
    func flipRotate(_ degrees : Double) -> some View {
        return self
            .rotation3DEffect(Angle(degrees: degrees), axis: (x: 0.0, y: 1.0, z: 0.0))
    }
    
    func placedOnCard(insets: EdgeInsets) -> some View {
        return self
            .padding(5)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(Color(.systemFill))
            .cornerRadius(20)
            .padding(.vertical, 20)
            .padding(.horizontal, 25)
            .shadow(color: .black.opacity(0.2), radius: 15)
            .padding(.top, insets.top + 30)
            .padding(.bottom, insets.bottom)
    }
}
