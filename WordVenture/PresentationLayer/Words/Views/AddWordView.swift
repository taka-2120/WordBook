//
//  AddingWordView.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/10/04.
//

import SwiftUI

struct AddWordView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var controller: AddWordController
    
    init(wordbook: Wordbook) {
        _controller = StateObject(wrappedValue: AddWordController(wordbook: wordbook))
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
                    
                    CommonWordSection(controller: controller, selectedImageIndex: $controller.selectedImageIndex) { }
                    
                    SmallFieldItem("synonyms", array: $controller.synonyms)
                    SmallFieldItem("antonyms", array: $controller.antonyms)
                    FieldItem("examples", array: $controller.examples)
                    
                    Divider()
                        .padding(.vertical)
                    
                    Text("apiNotes")
                        .font(.caption)
                        .foregroundColor(Color(.secondaryLabel))
                        .padding(.bottom)
                }
                .padding()
            }
            .environmentObject(controller)
            .animation(.spring(), value: controller.synonyms)
            .animation(.spring(), value: controller.antonyms)
            .animation(.spring(), value: controller.examples)
            .navigationBarTitle("newWord", displayMode: .inline)
            .sheet(isPresented: $controller.isPriorityShown) {
                PriorityView(selectedPriority: $controller.priority)
                    .presentationDetents([.medium])
            }
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
                        controller.addWord({ dismiss() })
                    } label: {
                        Text("add")
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
