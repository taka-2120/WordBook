//
//  AddingWordView.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/10/04.
//

import SwiftUI

struct AddWordView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var controller: AddWordController
    
    init(wordbook: Wordbook) {
        controller = AddWordController(wordbook: wordbook)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 15) {
                    CustomField("original", text: $controller.originalWord)
                    Text("wordNotes")
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                        .font(.callout)
                        .foregroundColor(Color(.secondaryLabel))
                    CustomField("translated", text: $controller.translatedWord)
                    
                    CommonWordSection(controller) { }
                    
                    SmallFieldItem("synonyms", array: $controller.synonyms)
                    SmallFieldItem("antonyms", array: $controller.antonyms)
                    FieldItem("examples", array: $controller.examples)
                    
                    Divider()
                        .padding(.vertical, 5)
                    
                    Text("Notes: \n • Unsplash API sometimes cannot find images. \n • Oepn AI API sometimes generate texts in wrong format, or containing incorrect information. \n • In free plan, image searching is limited for 1 times per word, and text generation is limited for 2 times per word. \n • In remove ads plan, image searching is limited for 2 times per word, and text generation is limited for 4 times per word.")
                        .font(.caption)
                        .foregroundColor(Color(.secondaryLabel))
                }
                .padding()
            }
            .environmentObject(controller)
            .animation(.spring(), value: controller.synonyms)
            .animation(.spring(), value: controller.antonyms)
            .animation(.spring(), value: controller.examples)
            .navigationBarTitle("newWord", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        controller.addWord(dismiss)
                    } label: {
                        Text("save")
                            .bold()
                    }
                    .disabled(controller.originalWord.isEmpty || controller.translatedWord.isEmpty)
                }
            }
            .alert("error", isPresented: $controller.isErrorShown) {
                Text("OK")
            } message: {
                Text(controller.errorMessage)
            }
            .loading($controller.isLoading)
        }
    }
}
