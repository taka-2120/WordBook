//
//  AddingWordView.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/10/04.
//

import SwiftUI

struct AddWordView: View {
    @ObservedObject private var controller: AddWordController
    @Environment(\.dismiss) var dismiss
    
    init(wordbook: Wordbook) {
        controller = AddWordController(wordbook: wordbook)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    CustomField("Original", text: $controller.originalWord)
                    CustomField("Translated", text: $controller.translatedWord)
                    
                    Button("Generate", action: controller.generateAll)
                        .disabled(controller.originalWord == "")
                    
                    Text("Synonyms")
                        .font(.headline)
                        .padding(.vertical, 10)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(controller.synonyms, id: \.self) { word in
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
                            ForEach(controller.antonyms, id: \.self) { word in
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
                    ForEach(controller.examples, id: \.self) { sentence in
                        Text(sentence)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationBarTitle("New Word", displayMode: .inline)
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
                        controller.addWord(dismiss)
                    } label: {
                        Text("Save")
                            .bold()
                    }
                    .disabled(controller.originalWord.isEmpty || controller.translatedWord.isEmpty)
                }
            }
        }
    }
}
