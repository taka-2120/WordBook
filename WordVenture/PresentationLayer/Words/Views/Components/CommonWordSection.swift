//
//  CommonSection.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/4/23.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct CommonWordSection<Content: View>: View {
    private let controller: WordController
    @Binding private var selectedImageIndex: Int
    private let editButton: () -> Content
    
    init(controller: WordController, selectedImageIndex: Binding<Int>, @ViewBuilder editButton: @escaping () -> Content) {
        self.controller = controller
        self._selectedImageIndex = selectedImageIndex
        self.editButton = editButton
    }
    
    var body: some View {
        VStack {
            Divider()
                .padding(.vertical)
            
            HStack {
                Text("priority")
                Spacer()
                Button {
                    controller.isPriorityShown.toggle()
                } label: {
                    HStack {
                        Text(controller.priority.label)
                        Image(systemName: controller.priority.symbol)
                    }
                }
                .foregroundStyle(controller.priority.color)
            }
            
            Divider()
                .padding(.vertical)
            
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
                    
                    if controller.isImageNotFound {
                        HStack {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.red)
                            Text("imageNotFound")
                                .font(.callout)
                                .foregroundColor(Color(.secondaryLabel))
                        }
                    } else {
                        Group {
                            Text("imageNotes")
                            
                            Text("* ") + Text("imageCachingNotes")
                        }
                        .font(.callout)
                        .foregroundColor(Color(.secondaryLabel))
                    }
                } else {
                    HStack(alignment: .top) {
                        Text("relatedImage")
                            .font(.headline)
                        
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
                            ForEach(Array(controller.imageUrls.enumerated()), id: \.offset) { index, imageUrl in
                                SelectableRelatedImage(url: imageUrl, index: index, selectedIndex: $selectedImageIndex)
                            }
                        }
                    }
                    .cornerRadius(15)
                    
                    VStack(alignment: .leading) {
                        Text("thumbnailNotes")
                        
                        Text("imageCachingNotes")
                    }
                    .font(.callout)
                    .foregroundStyle(Color(.secondaryLabel))
                    .frame(minWidth: 0, maxWidth: .infinity)
                }
            }
            
            Divider()
                .padding(.vertical)
            
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
                    .padding(.top, 5)
                    
                    Text("textNotes")
                        .font(.callout)
                        .foregroundColor(Color(.secondaryLabel))
                        .padding(.bottom)
                } else {
                    HStack {
                        Spacer()
                        editButton()
                        
                        Button {
                            controller.generateAll()
                        } label: {
                            Image(systemName: "arrow.counterclockwise")
                                .foregroundColor(Color(.secondaryLabel))
                        }
                    }
                }
            }
        }
        .animation(.spring(), value: controller.isImageNotFound)
    }
}

func ApiNotes() -> some View {
    VStack(alignment: .leading) {
        Divider()
            .padding(.vertical, 5)
        
        Text("apiNotes")
            .font(.caption)
            .foregroundColor(Color(.secondaryLabel))
            .padding(.bottom)
    }
    .frame(minWidth: 0, maxWidth: .infinity)
}
