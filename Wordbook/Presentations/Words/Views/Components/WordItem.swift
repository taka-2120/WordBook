//
//  WordItem.swift
//  WordBook
//
//  Created by Yu Takahashi on 2022/07/03.
//

import SwiftUI
import SwipeActions

struct WordItem: View {
    @EnvironmentObject private var controller: WordsController
    
    let word: Word
    let index: Int
    
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
                .background(.regularMaterial)
                .cornerRadius(15)
            }
        } trailingActions: { _ in
            SwipeAction(systemImage: "square.and.pencil") {
                controller.selectWord(for: word)
                controller.isDetailsShown.toggle()
            }
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(15)
            
            SwipeAction(systemImage: "trash") {
                controller.removeWord(at: index)
            }
            .allowSwipeToTrigger()
            .background(.red)
            .foregroundColor(.white)
        }
        .swipeActionWidth(80)
        .swipeActionCornerRadius(15)
        .swipeActionsMaskCornerRadius(15)
        .swipeEnableTriggerHaptics(true)
        .padding(.horizontal)
    }
}
