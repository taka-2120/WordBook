//
//  WordItem.swift
//  WordBook
//
//  Created by Yu Takahashi on 2022/07/03.
//

import SwiftUI

struct WordItem: View {
    let word: Word
    @State var isInfoShown = false
    
    var body: some View {
        Button(action: {
            isInfoShown.toggle()
        }, label: {
            HStack {
                Circle()
                    .fill(getPriorityColor(priority: word.priority))
                    .frame(maxWidth: 10, maxHeight: 10)
                Text(word.original)
                    .foregroundColor(Color(.label))
                    .fontWeight(.semibold)
                Spacer()
                Text(word.translated)
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
                // TODO: Remove Action
            }) {
                Text("Delete")
                Image(systemName: "trash")
            }
            .foregroundColor(Color(.systemRed))
        }
        .shadow(color: Color(.systemGray5), radius: 10)
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}
