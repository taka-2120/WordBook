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
                VStack(spacing: 15) {
                    CustomField("Original", text: $controller.originalWord)
                    CustomField("Translated", text: $controller.translatedWord)
                    
                    Group {
                        Button("Generate", action: controller.generateAll)
                            .padding(.vertical)
                            .padding(.horizontal, 30)
                            .background(.blue)
                            .opacity(controller.originalWord == "" ? 0.7 : 1.0)
                            .cornerRadius(20)
                            .foregroundColor(.white)
                            .disabled(controller.originalWord == "")
                        
                        Text("Open AI will generate following these fields")
                            .font(.callout)
                            .foregroundColor(Color(.secondaryLabel))
                            .padding(.bottom)
                    }
                    
                    SmallFieldItem("Synonyms", array: $controller.synonyms)
                    
                    SmallFieldItem("Antonyms", array: $controller.antonyms)
                    
                    FieldItem("Examples", array: $controller.examples)
                    
                    Spacer()
                }
                .padding()
            }
            .loading($controller.isLoading)
            .animation(.spring(), value: controller.synonyms)
            .animation(.spring(), value: controller.antonyms)
            .animation(.spring(), value: controller.examples)
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
