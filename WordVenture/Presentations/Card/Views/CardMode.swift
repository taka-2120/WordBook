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
    @Environment(\.colorScheme) private var colorScheme
    
    @StateObject private var cardController = CardController()
    @StateObject private var page: Page = .first()
    @EnvironmentObject private var controller: WordsController
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { geo in
                Pager(page: page,
                      data: controller.wordbook.words,
                      id: \.id) { word in
                    CardItem(word: word, isImageShown: $cardController.isAlwaysImageShown, geo: geo)
                }
                      .preferredItemSize(CGSize(width: geo.size.width - 70, height: .infinity))
                      .itemSpacing(8)
                      .interactive(scale: 0.8)
                      .interactive(rotation: true)
                      .edgesIgnoringSafeArea(.all)
                      .background(Color(.systemGroupedBackground))
                      .onAppear {
                          let isCardModeOpened = UserDefaults.standard.bool(forKey: isCardModeOpenedKey)
                          
                          if !isCardModeOpened {
                              cardController.isCardModeShown = true
                              UserDefaults.standard.set(true, forKey: isCardModeOpenedKey)
                          }
                      }
            }
            
            HStack(alignment: .center, spacing: 15) {
                Spacer()
                
                Menu {
                    Toggle(isOn: $cardController.isAlwaysImageShown) {
                        Label("alwaysShowImages", systemImage: "photo")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .foregroundStyle(Color(.secondaryLabel))
                        .imageScale(.large)
                }

                DismissButton(dismiss, colorScheme)
                    .padding(.trailing)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.top, 10)
            
            HStack {
                Spacer()
                Text("\(page.index + 1) / \(controller.wordbook.words.count)")
                    .foregroundStyle(Color(.secondaryLabel))
                    .padding()
                Spacer()
            }
            
            ZStack(alignment: .center) {
                if cardController.isMissedShown {
                    Rectangle()
                        .fill(Color(.systemGray6).opacity(0.4))
                        .ignoresSafeArea()
                        .frame(minWidth: 0, maxWidth: .infinity)
                    MissedOverlay
                        .transition(.scale)
                }
            }
        }
        .environmentObject(page)
        .environmentObject(cardController)
        .animation(.bouncy, value: cardController.isMissedShown)
        .toolbar(.hidden, for: .navigationBar)
        .sheet(isPresented: $cardController.isCardModeShown) {
            CardIntroductionView()
        }
    }
    
    private var MissedOverlay: some View {
        VStack(spacing: 15) {
            Image(systemName: "xmark")
                .font(.system(size: 64))
                .bold()
                .foregroundStyle(.red.opacity(0.8))
                .padding()
            
            Text("missedLabel")
                .padding(.bottom)
            
            HStack(alignment: .top, spacing: 15) {
                Button {
                    withAnimation {
                        cardController.isMissedShown.toggle()
                    }
                } label: {
                    Text("undo")
                        .foregroundStyle(Color(.label))
                        .padding(.vertical, 12)
                        .frame(minWidth: 80, maxWidth: 150)
                }
                .background(Color(.systemGray4))
                .cornerRadius(15)
                .shadow(color: .black.opacity(0.1), radius: 10, y: 2)
                
                Button {
                    controller.incrementMissedCount(for: page.index)
                    withAnimation {
                        cardController.isMissedShown.toggle()
                    }
                    withAnimation {
                        page.update(.next)
                    }
                } label: {
                    Text("next")
                        .foregroundStyle(.white)
                        .padding(.vertical, 12)
                        .frame(minWidth: 80, maxWidth: 150)
                }
                .background(.blue)
                .cornerRadius(15)
                .shadow(color: .black.opacity(0.1), radius: 10, y: 2)
            }
        }
        .padding()
        .background(.regularMaterial)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 15, y: 4)
        .padding()
    }
}

fileprivate struct CardItem: View {
    
    @EnvironmentObject private var controller: WordsController
    @EnvironmentObject private var cardController: CardController
    @EnvironmentObject private var page: Page
    
    @Binding private var isImageShown: Bool
    
    @State private var isDetailShown = false
    private let word: Word
    private let geo: GeometryProxy
    
    init(word: Word, isImageShown: Binding<Bool>, geo: GeometryProxy) {
        self.word = word
        self.geo = geo
        self._isImageShown = isImageShown
    }
    
    var body: some View {
        ZStack {
            content(isFront: true)
                .cardFlip(id: word.id, insets: geo.safeAreaInsets) {
                    content(isFront: false)
                }
                .animation(.spring, value: isImageShown)
        }
    }
    
    private func content(isFront: Bool) -> some View {
        VStack {
            Spacer()
            Text(isFront ? word.original : word.translated)
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            
            if isFront {
                ImageSection
                
                HStack {
                    Button {
                        isImageShown.toggle()
                    } label: {
                        Image(systemName: isImageShown ? "eye.slash" : "photo")
                            .imageScale(.large)
                            .foregroundStyle(Color(.label))
                    }
                    .disabled(word.imageUrls.isEmpty)
                    .opacity(word.imageUrls.isEmpty ? 0.5 : 1.0)
                    
                    Spacer()
                }
            } else {
                Divider()
                
                SmallFieldItem("synonyms", array: .constant(word.synonyms), isEditing: false)
                SmallFieldItem("antonyms", array: .constant(word.antonyms), isEditing: false)
                FieldItem("examples", array: .constant(word.examples), isEditing: false)
                    .padding(.bottom)
                
                HStack {
                    Button {
                        withAnimation {
                            feedbackGenerator(type: .error)
                            cardController.isMissedShown.toggle()
                        }
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.red)
                            .font(.system(size: 28))
                    }
                    Spacer()
                    Button {
                        withAnimation {
                            feedbackGenerator(type: .success)
                            page.update(.next)
                        }
                    } label: {
                        Image(systemName: "circle.circle.fill")
                            .foregroundStyle(.green)
                            .font(.system(size: 28))
                    }
                }
            }
        }
        .padding()
    }
    
    private var ImageSection: some View {
        Group {
            if let url = word.imageUrls.first, isImageShown {
                Divider()
                RelatedImage(url: url, height: 200)
            }
        }
    }
}

fileprivate struct CardFlip: ViewModifier {
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
