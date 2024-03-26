//
//  FlashCardMode.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/10/10.
//

import SwiftUI
import SwiftUIPager

struct FlashCardMode: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    @EnvironmentObject private var controller: WordsController
    @StateObject private var flashCardController = FlashCardController()
    @StateObject private var page: Page = .first()
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { geo in
                Pager(page: page,
                      data: controller.wordbook.words,
                      id: \.id) { word in
                    FlashCardItem(word: word, isImageShown: $flashCardController.isAlwaysImageShown, geo: geo)
                }
                      .preferredItemSize(CGSize(width: geo.size.width - 70, height: .infinity))
                      .itemSpacing(8)
                      .interactive(scale: 0.8)
                      .interactive(rotation: true)
                      .edgesIgnoringSafeArea(.all)
                      .background(Color(.systemGroupedBackground))
                      .onAppear {
                          let isCardModeOpened = UserDefaults.standard.bool(forKey: UserDefaultsKey.isCardModeOpenedKey.rawValue)
                          
                          if !isCardModeOpened {
                              flashCardController.isCardModeShown = true
                              UserDefaults.standard.set(true, forKey: UserDefaultsKey.isCardModeOpenedKey.rawValue)
                          }
                      }
            }
            
            HStack(alignment: .center, spacing: 15) {
                Spacer()
                
                Menu {
                    Toggle(isOn: $flashCardController.isAlwaysImageShown) {
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
        }
        .environmentObject(page)
        .environmentObject(flashCardController)
        .toolbar(.hidden, for: .navigationBar)
        .sheet(isPresented: $flashCardController.isCardModeShown) {
            CardIntroductionView()
        }
    }
}
