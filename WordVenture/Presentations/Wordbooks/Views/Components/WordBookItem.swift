//
//  WordBookItem.swift
//  WordBook
//
//  Created by Yu Takahashi on 2022/07/03.
//

import Combine
import SwiftUI
import SwipeActions

struct WordbookItem: View {
    @EnvironmentObject private var controller: WordbooksController
    @State private var close = PassthroughSubject<Void, Never>()
    @State private var isDeletePromptShown = false
    
    private let wordbook: Wordbook
    private let index: Int
    
    init(wordbook: Wordbook, index: Int) {
        self.wordbook = wordbook
        self.index = index
    }
    
    var body: some View {
        SwipeView {
            NavigationLink(destination: WordsView(wordbook: wordbook, at: index)) {
                HStack {
                    Text(wordbook.name)
                        .font(.headline)
                        .foregroundColor(Color(.label))
                    Spacer()
                    Text("\(wordbook.words.count)")
                        .font(.subheadline)
                        .foregroundColor(Color(.secondaryLabel))
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                        .imageScale(.small)
                }
                .padding(.horizontal)
                .padding(.vertical, 20)
            }
            .background(.regularMaterial)
            .cornerRadius(15)
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .strokeBorder(Color(hex: wordbook.color).opacity(0.8), lineWidth: 2)
            }
            .shadow(color: Color(hex: wordbook.color).opacity(0.3), radius: 15, y: 3)
        } trailingActions: { context in
            SwipeAction(systemImage: "trash") {
                isDeletePromptShown.toggle()
            }
            .allowSwipeToTrigger()
            .background(.red)
            .foregroundColor(.white)
            .onReceive(close) { _ in /// Receive the `PassthroughSubject`.
                context.state.wrappedValue = .closed
            }
        }
        .swipeActionWidth(80)
        .swipeActionCornerRadius(15)
        .swipeActionsMaskCornerRadius(15)
        .swipeEnableTriggerHaptics(true)
        .padding(.horizontal)
        .alert(L10n.deleteWordbookWarning.rawValue, isPresented: $isDeletePromptShown) {
            Button(role: .destructive) {
                controller.removeWordbook(at: index)
                close.send()
            } label: {
                Text(L10n.delete.rawValue)
            }
            Button(role: .cancel) {
                close.send()
            } label: {
                Text(L10n.cancel.rawValue)
            }
        }
    }
}
