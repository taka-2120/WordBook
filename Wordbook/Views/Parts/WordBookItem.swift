//
//  WordBookItem.swift
//  WordBook
//
//  Created by Yu Takahashi on 2022/07/03.
//

import SwiftUI

struct WordBookItem: View {
    var name: String
    var date: String
    @Binding var isNavBarHidden: Bool
    @Binding var wordbooks: [WordBooks]
    var selectedId: UUID
    
    var body: some View {
        NavigationLink(destination: WordsView(wordbooks: $wordbooks, isNavBarHidden: $isNavBarHidden, wordbookId: selectedId)) {
            VStack(alignment: .trailing) {
                HStack {
                    Text(name)
                        .foregroundColor(Color(.label))
                        .fontWeight(.semibold)
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "info.circle")
                            .foregroundColor(Color(.secondaryLabel))
                    })
                }
                Text("Last Modified: \(date)")
                    .padding(.top, 5)
                    .foregroundColor(Color(.secondaryLabel).opacity(0.7))
            }
            .padding()
            .background()
            .cornerRadius(15)
            .shadow(color: Color(.systemGray5), radius: 10)
            .padding(.horizontal)
            .padding(.vertical, 5)
        }
    }
}

struct WordBookItem_Previews: PreviewProvider {
    static var previews: some View {
        WordBookItem(name: "Test", date: "2022/07/03", isNavBarHidden: .constant(false), wordbooks: .constant([WordBooks]()), selectedId: UUID())
    }
}
