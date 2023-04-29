//
//  WordBookItem.swift
//  WordBook
//
//  Created by Yu Takahashi on 2022/07/03.
//

import SwiftUI
import SwipeActions

struct WordbookItem: View {
    @EnvironmentObject private var controller: WordbooksController
    let wordbook: Wordbook
    let index: Int
    
    var body: some View {
        SwipeView {
            NavigationLink(value: wordbook) {
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
        } trailingActions: { _ in
            SwipeAction(systemImage: "pin") {
                controller.pinWordbook()
            }
            .background(.orange)
            .foregroundColor(.white)
            
            SwipeAction(systemImage: "trash") {
                controller.removeWordbook(at: index)
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
        .padding(.vertical, 5)
    }
}

struct WordBookItem_Previews: PreviewProvider {
    static var previews: some View {
        WordbookItem(wordbook: wordbooksMock[0], index: 0)
    }
}
