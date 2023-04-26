//
//  WordsView.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/10/04.
//

import SwiftUI
import VisionKit
import Vision

struct WordsView: View {
    @ObservedObject private var controller: WordsController
    
    init(wordbook: Wordbook) {
        self.controller = WordsController(wordbook: wordbook)
    }
    
    var body: some View {
        List {
            ForEach(controller.wordbook.words, id: \.id) { word in
                Button {
                    controller.isDetailsShown.toggle()
                } label: {
                    HStack {
                        Text(word.original)
                            .foregroundColor(Color(.label))
                        Spacer()
                        Text(word.translated)
                            .foregroundColor(Color(.secondaryLabel))
                    }
                }
                .sheet(isPresented: $controller.isDetailsShown) {
                    DetailsView(wordbook: controller.wordbook, word: word)
                }
            }
        }
        .navigationBarTitle("Words")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    controller.isAddShown.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $controller.isAddShown, content: { AddWordView(wordbook: controller.wordbook) })
        .animation(.easeInOut, value: controller.wordbook)
    }
}

//struct WordsView_Previews: PreviewProvider {
//    static var previews: some View {
//        WordsView(wordbooks: .constant([WordBooks(name: "System English Words", words: [], modifiedDate: Date())]), isNavBarHidden: .constant(false), wordbookId: UUID())
//    }
//}
