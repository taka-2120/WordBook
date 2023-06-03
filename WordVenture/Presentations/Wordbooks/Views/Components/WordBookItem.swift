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
    @State var close = PassthroughSubject<Void, Never>()
    @State private var isDeletePromptShown = false
    
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
//        } leadingActions: { context in
//            SwipeAction(systemImage: "pin") {
//                controller.pinWordbook()
//            }
//            .background(.orange)
//            .foregroundColor(.white)
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
        .padding(.vertical, 5)
        .alert("deleteWordbookWarning", isPresented: $isDeletePromptShown) {
            Button(role: .destructive) {
                controller.removeWordbook(at: index)
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

struct WordBookItem_Previews: PreviewProvider {
    static var previews: some View {
        WordbookItem(wordbook: wordbooksMock[0], index: 0)
    }
}
