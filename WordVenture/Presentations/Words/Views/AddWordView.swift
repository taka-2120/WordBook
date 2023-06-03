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
                    CustomField("original", text: $controller.originalWord)
                    Text("wordNotes")
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                        .font(.callout)
                        .foregroundColor(Color(.secondaryLabel))
                    CustomField("translated", text: $controller.translatedWord)
                    
                    Divider()
                        .padding(.vertical, 5)
                    
                    VStack {
                        if controller.imageUrls.isEmpty {
                            Button {
                                controller.generateImages()
                            } label: {
                                HStack {
                                    Text("generateImage")
                                        .padding(.vertical)
                                }
                                .frame(maxWidth: 180)
                            }
                            .background(.blue)
                            .opacity(controller.originalWord == "" ? 0.7 : 1.0)
                            .cornerRadius(20)
                            .foregroundColor(.white)
                            .disabled(controller.originalWord == "")
                            
                            if controller.isImageSearched {
                                HStack {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.red)
                                    Text("imageNotFound")
                                        .font(.callout)
                                        .foregroundColor(Color(.secondaryLabel))
                                }
                            } else {
                                Text("imageNotes")
                                    .font(.callout)
                                    .foregroundColor(Color(.secondaryLabel))
                                    .padding(.bottom)
                            }
                        } else {
                            HStack(alignment: .top) {
                                VStack(alignment: .leading) {
                                    Text("relatedImage")
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
                                    Text("generateText")
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
                            
                            Text("textNotes")
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
                    
                    SmallFieldItem("synonyms", array: $controller.synonyms)
                    
                    SmallFieldItem("antonyms", array: $controller.antonyms)
                    
                    FieldItem("examples", array: $controller.examples)
                }
                .padding()
            }
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
