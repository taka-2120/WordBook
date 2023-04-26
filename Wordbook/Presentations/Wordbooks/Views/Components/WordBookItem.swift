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
                .padding(.vertical, 20)
            }
            .background(.regularMaterial)
            .cornerRadius(15)
        } trailingActions: { _ in
            SwipeAction(systemImage: "pin") {
                controller.pinWordbook()
            }
            .background(.orange)
            .cornerRadius(15)
            
            SwipeAction(systemImage: "trash") {
                controller.removeWordbook()
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

struct WordBookItem_Previews: PreviewProvider {
    static var previews: some View {
        WordbookItem(wordbook: wordbooksMock[0])
    }
}
