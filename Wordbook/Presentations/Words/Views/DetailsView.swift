//
//  EditingView.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/10/04.
//

import SwiftUI

struct DetailsView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var controller: DetailsWordController
    
    init(wordbook: Wordbook, word: Word) {
        self.controller = DetailsWordController(wordbook: wordbook, word: word)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    CustomField("Original", text: $controller.originalWord)
                    CustomField("Translated", text: $controller.translatedWord)
                    
                    Text("Synonyms")
                        .font(.headline)
                        .padding(.vertical, 10)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(controller.word.synonyms, id: \.self) { word in
                                Text(word)
                                    .padding(10)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                            }
                        }
                    }
                    
                    Text("Antonyms")
                        .font(.headline)
                        .padding(.vertical, 10)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(controller.word.antonyms, id: \.self) { word in
                                Text(word)
                                    .padding(10)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                            }
                        }
                    }
                    
                    Text("Examples")
                        .font(.headline)
                        .padding(.vertical, 10)
                    ForEach(controller.word.examples, id: \.self) { sentence in
                        Text(sentence)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationBarTitle(Text(controller.word.original), displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        controller.updateWord()
                        dismiss()
                    } label: {
                        Text("Save")
                            .bold()
                    }
                }
            }
        }
    }
}
