//
//  AddingWordView.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/10/04.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct AddWordView: View {
    @ObservedObject private var controller: AddWordController
    @Environment(\.dismiss) private var dismiss
    
    init(wordbook: Wordbook) {
        controller = AddWordController(wordbook: wordbook)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 15) {
                    CustomField("Original", text: $controller.originalWord)
                    Text("In your studying language")
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                        .font(.callout)
                        .foregroundColor(Color(.secondaryLabel))
                    CustomField("Translated", text: $controller.translatedWord)
                    
                    Divider()
                        .padding(.vertical, 5)
                    
                    VStack {
                        if controller.imageUrls.isEmpty {
                            Button {
                                controller.generateImages()
                            } label: {
                                HStack {
                                    Text("Generate Image")
                                        .padding(.vertical)
                                }
                                .frame(maxWidth: 180)
                            }
                            .background(.blue)
                            .opacity(controller.originalWord == "" ? 0.7 : 1.0)
                            .cornerRadius(20)
                            .foregroundColor(.white)
                            .disabled(controller.originalWord == "")
                            
                            Text("Unsplash will generate matched images here")
                                .font(.callout)
                                .foregroundColor(Color(.secondaryLabel))
                                .padding(.bottom)
                        } else {
                            HStack(alignment: .top) {
                                VStack(alignment: .leading) {
                                    Text("Related Image")
                                        .font(.headline)
//                                    Text("Tap to set a thumbnail image")
//                                        .font(.caption)
//                                        .foregroundColor(Color(.secondaryLabel))
                                }
                                Spacer()
                                Button {
                                    controller.generateImages()
                                } label: {
                                    Image(systemName: "arrow.counterclockwise")
                                        .foregroundColor(Color(.secondaryLabel))
                                }
                            }
                            ScrollView(.horizontal, showsIndicators: true) {
                                HStack {
                                    ForEach(controller.imageUrls, id: \.self) { imageUrl in
                                        RelatedImage(url: imageUrl)
                                    }
                                }
                            }
                            .cornerRadius(15)
                        }
                    }
                    
                    Divider()
                        .padding(.vertical, 5)
                    
                    VStack {
                        if controller.antonyms.isEmpty && controller.synonyms.isEmpty && controller.examples.isEmpty {
                            Button {
                                controller.generateAll()
                            } label: {
                                HStack {
                                    Text("Generate Text")
                                        .padding(.vertical)
                                    LoadingIndicator(animation: .circleBars, color: .white, size: .small)
                                        .scaleEffect(0.8)
                                        .isHidden(!controller.isGenerating, remove: true)
                                }
                                .frame(maxWidth: 180)
                            }
                            .background(.blue)
                            .opacity(controller.originalWord == "" ? 0.7 : 1.0)
                            .cornerRadius(20)
                            .foregroundColor(.white)
                            .disabled(controller.originalWord == "" || controller.isGenerating)
                            
                            Text("Open AI will fill following these fields")
                                .font(.callout)
                                .foregroundColor(Color(.secondaryLabel))
                                .padding(.bottom)
                        } else {
                            HStack {
                                Spacer()
                                Button {
                                    controller.generateAll()
                                } label: {
                                    Image(systemName: "arrow.counterclockwise")
                                        .foregroundColor(Color(.secondaryLabel))
                                }
                            }
                        }
                    }
                    
                    SmallFieldItem("Synonyms", array: $controller.synonyms)
                    
                    SmallFieldItem("Antonyms", array: $controller.antonyms)
                    
                    FieldItem("Examples", array: $controller.examples)
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
