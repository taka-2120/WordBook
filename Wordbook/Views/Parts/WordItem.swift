//
//  WordItem.swift
//  WordBook
//
//  Created by Yu Takahashi on 2022/07/03.
//

import SwiftUI

struct WordItem: View {
    var word: Words
    var wordbookIndex: Int
    @Binding var words: [Words]
    @Binding var wordbooks: [WordBooks]
    @State var isInfoShown = false
    
    var body: some View {
        Button(action: {
            isInfoShown.toggle()
        }, label: {
            HStack {
                Circle()
                    .fill(priorityDetector(priority: word.priority))
                    .frame(maxWidth: 10, maxHeight: 10)
                Text(word.originalWord)
                    .foregroundColor(Color(.label))
                    .fontWeight(.semibold)
                Spacer()
                Text(word.translatedWord)
                    .foregroundColor(Color(.secondaryLabel))
            }
        })
        .padding()
        .background()
        .cornerRadius(15)
        .contextMenu {
            Button(action: {
                isInfoShown = true
            }) {
                Text("Edit")
                Image(systemName: "square.and.pencil")
            }

            Button(action: {
                for i in 0 ... words.count {
                    if words[i].id == word.id {
                        words.remove(at: i)
                        wordbooks[wordbookIndex].words.remove(at: i)
                        return
                    }
                }
            }) {
                Text("Delete")
                Image(systemName: "trash")
            }
            .foregroundColor(Color(.systemRed))
        }
        .shadow(color: Color(.systemGray5), radius: 10)
        .padding(.horizontal)
        .padding(.vertical, 5)
        .sheet(isPresented: $isInfoShown) {
            EditingView(word: word, wordbookIndex: wordbookIndex, wordbooks: $wordbooks, words: $words)
        }
    }
}
