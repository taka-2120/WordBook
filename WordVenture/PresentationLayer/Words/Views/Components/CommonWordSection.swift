//
//  CommonSection.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/4/23.
//

import SwiftUI
import SwiftfulLoadingIndicators

func CommonWordSection<Content: View>(_ controller: WordController, @ViewBuilder _ editButton: () -> Content) -> some View {
    return VStack {
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
}
