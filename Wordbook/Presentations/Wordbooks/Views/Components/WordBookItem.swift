//
//  WordBookItem.swift
//  WordBook
//
//  Created by Yu Takahashi on 2022/07/03.
//

import SwiftUI

struct WordbookItem: View {
    let wordbook: Wordbook
    
    var body: some View {
        NavigationLink(value: wordbook) {
            HStack {
                Text(wordbook.name)
                    .font(.headline)
                    .foregroundColor(Color(.label))
                Spacer()
                Text("\(wordbook.words.count)")
                    .font(.subheadline)
                    .foregroundColor(Color(.secondaryLabel))
            }
        }
    }
}

struct WordBookItem_Previews: PreviewProvider {
    static var previews: some View {
        WordbookItem(wordbook: wordbooksMock[0])
    }
}
