//
//  EditingView.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/10/04.
//

import SwiftUI

struct DetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var controller: DetailsWordController
    
    init(wordbook: Wordbook, word: Word) {
        _controller = StateObject(wrappedValue: DetailsWordController(wordbook: wordbook, word: word))
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
                    
                    CommonWordSection(controller) {
                        Button {
                            controller.isEditing.toggle()
                        } label: {
                            Text(controller.isEditing ? "done" : "edit")
                        }
                        .padding(.trailing)
                    }
                    
                    SmallFieldItem("synonyms", array: $controller.synonyms, isEditing: controller.isEditing)
                    SmallFieldItem("antonyms", array: $controller.antonyms, isEditing: controller.isEditing)
                    FieldItem("examples", array: $controller.examples, isEditing: controller.isEditing)
                }
                .padding()
            }
            .environmentObject(controller)
            .animation(.spring(), value: controller.synonyms)
            .animation(.spring(), value: controller.antonyms)
            .animation(.spring(), value: controller.examples)
            .animation(.spring(), value: controller.isEditing)
            .navigationBarTitle(Text(controller.word.original), displayMode: .inline)
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
                        controller.updateWord(dismiss: dismiss)
                    } label: {
                        Text("save")
                            .bold()
                    }
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
