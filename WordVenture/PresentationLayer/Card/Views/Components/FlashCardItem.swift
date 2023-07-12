//
//  CardItem.swift
//  WordVenture
//
//  Created by Yu Takahashi on 7/7/23.
//

import SwiftUI
import SwiftUIPager

struct FlashCardItem: View {
    
    @EnvironmentObject private var flashCardController: FlashCardController
    @Binding private var isImageShown: Bool
    
    private let word: Word
    private let geo: GeometryProxy
    
    init(word: Word, isImageShown: Binding<Bool>, geo: GeometryProxy) {
        self.word = word
        self.geo = geo
        self._isImageShown = isImageShown
    }
    
    var body: some View {
        ZStack {
            content(isFront: true)
                .cardFlip(id: word.id, insets: geo.safeAreaInsets) {
                    content(isFront: false)
                }
                .animation(.spring, value: isImageShown)
        }
    }
    
    private func content(isFront: Bool) -> some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    flashCardController.speakWord(for: isFront ? word.original : word.translated)
                } label: {
                    Image(systemName: "speaker.wave.2.fill")
                }
            }
            .isHidden(true, remove: true)
            
            Spacer()
            Text(isFront ? word.original : word.translated)
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            
            if isFront {
                ImageSection
                
                HStack {
                    Button {
                        isImageShown.toggle()
                    } label: {
                        Image(systemName: isImageShown ? "eye.slash" : "photo")
                            .imageScale(.large)
                            .foregroundStyle(Color(.label))
                    }
                    .disabled(word.imageUrls.isEmpty)
                    .opacity(word.imageUrls.isEmpty ? 0.5 : 1.0)
                    
                    Spacer()
                }
            } else {
                Divider()
                
                SmallFieldItem("synonyms", array: .constant(word.synonyms), isEditing: false)
                SmallFieldItem("antonyms", array: .constant(word.antonyms), isEditing: false)
                FieldItem("examples", array: .constant(word.examples), isEditing: false)
                    .padding(.bottom)
            }
        }
        .padding()
    }
    
    private var ImageSection: some View {
        Group {
            if !word.thumbnailUrl.isEmpty, isImageShown {
                Divider()
                RelatedImage(url: word.thumbnailUrl, height: 200)
            }
        }
    }
}
