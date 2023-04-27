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
                    
                    VStack(alignment: .leading) {
                        Text("Synonyms")
                            .font(.headline)
                            .padding(.vertical, 10)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(Array(controller.synonyms.enumerated()), id: \.offset) { index, word in
                                    HStack {
                                        Button {
                                            
                                        } label: {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(Color(.systemGray))
                                                .imageScale(.small)
                                        }

                                        TextField("Synonyms", text: $controller.synonyms[index])
                                    }
                                    .padding(10)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(100)
                                }
                            }
                        }
                        
                        Text("Antonyms")
                            .font(.headline)
                            .padding(.vertical, 10)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(Array(controller.antonyms.enumerated()), id: \.offset) { index, word in
                                    HStack {
                                        Button {
                                            
                                        } label: {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(Color(.systemGray))
                                                .imageScale(.small)
                                        }

                                        TextField("Antonyms", text: $controller.antonyms[index])
                                    }
                                    .padding(10)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(100)
                                }
                            }
                        }
                        
                        Text("Examples")
                            .font(.headline)
                            .padding(.vertical, 10)
                        ForEach(Array(controller.examples.enumerated()), id: \.offset) { index, sentence in
                            Text("\(index + 1). \(sentence)")
                        }
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
