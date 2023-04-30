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
                        controller.updateWord(dismiss: dismiss)
                    } label: {
                        Text("Save")
                            .bold()
                    }
                }
            }
        }
    }
}
