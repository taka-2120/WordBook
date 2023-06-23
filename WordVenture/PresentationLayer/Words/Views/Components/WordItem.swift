//
//  WordItem.swift
//  WordBook
//
//  Created by Yu Takahashi on 2022/07/03.
//

import Combine
import SwiftUI
import SwipeActions

struct WordItem: View {
    @EnvironmentObject private var controller: WordsController
    @State private var close = PassthroughSubject<Void, Never>()
    @State private var isDeletePromptShown = false
    
    private let word: Word
    private let index: Int
    
    init( word: Word, index: Int) {
        self.word = word
        self.index = index
    }
    
    var body: some View {
        SwipeView {
            Button {
                controller.selectWord(for: word)
                controller.isDetailsShown.toggle()
            } label: {
                HStack {
                    Text(word.original)
                        .font(.headline)
                        .foregroundColor(Color(.label))
                    Spacer()
                    Text("\(word.translated)")
                        .font(.subheadline)
                        .foregroundColor(Color(.secondaryLabel))
                }
                .padding(.horizontal)
                .padding(.vertical, 20)
                .background(Color(.systemFill))
                .cornerRadius(15)
            }
//        } leadingActions: { context in
//            SwipeAction(systemImage: "pin") {
//                controller.pinWordbook()
//            }
//            .background(.orange)
//            .foregroundColor(.white)
        } trailingActions: { context in
            SwipeAction(systemImage: "square.and.pencil") {
                controller.selectWord(for: word)
                controller.isDetailsShown.toggle()
            }
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(15)
            
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
        .padding(.vertical, 5)
        .alert("deleteWordWarning", isPresented: $isDeletePromptShown) {
            Button(role: .destructive) {
                controller.removeWord(at: index)
                close.send()
            } label: {
                Text("delete")
            }
            Button(role: .cancel) {
                close.send()
            } label: {
                Text("cancel")
            }
        }
    }
}
