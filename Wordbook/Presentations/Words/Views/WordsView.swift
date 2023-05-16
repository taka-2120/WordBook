//
//  WordsView.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/10/04.
//

import SwiftUI
import VisionKit
import Vision
import SwipeActions
import PresentableColorPicker

struct WordsView: View {
    @ObservedObject private var controller: WordsController
    @State private var isEditing = false
    
    init(wordbook: Wordbook) {
        self.controller = WordsController(wordbook: wordbook)
    }
    
    var body: some View {
        ZStack {
            if controller.wordbook.words.isEmpty {
                VStack {
                    Image(systemName: "rectangle.portrait.on.rectangle.portrait.slash")
                        .symbolRenderingMode(.hierarchical)
                        .font(.system(size: 64))
                        .padding()
                    Text("No Words")
                        .font(.title3)
                        .bold()
                }
            } else {
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "play.fill")
                                .padding()
                        }
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "plus")
                                .padding()
                        }
                        
                        Spacer()
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(15)
                    .shadow(color: .black.opacity(0.1), radius: 15, y: 3)
                    .padding()
                    .zIndex(100)
                    
                    ScrollView {
                        SwipeViewGroup {
                            ForEach(Array(controller.wordbook.words.enumerated()), id: \.offset) { index, word in
                                WordItem(word: word, index: index)
                            }
                            .padding(.top, 30)
                        }
                    }
                    .padding(.top, -25)
                }
            }
            
            if isEditing {
                Rectangle()
                    .fill(Color(.systemBackground).opacity(0.1))
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .onTapGesture {
                        isEditing = false
                    }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.browser)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Circle()
                        .fill(Color(hex: controller.wordbook.color))
                        .frame(width: 10, height: 10)
                    TextField("Wordbook Title", text: $controller.wordbookTitle)
                        .padding(8)
                        .background(isEditing ? Color(.secondarySystemBackground) : .clear)
                        .cornerRadius(10)
                        .frame(minWidth: 0, maxWidth: 150, alignment: .center)
                        .disabled(!isEditing)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                if isEditing {
                    Button {
                        controller.updateTitle()
                        isEditing = false
                    } label: {
                        Text("Done")
                    }
                } else {
                    ColorPicker("", selection: $controller.wordbookColor)
                        .scaleEffect(0.8)
                }
            }
            
            ToolbarTitleMenu {
                if !isEditing {
                    Button {
                        isEditing = true
                    } label: {
                        Label("Rename", systemImage: "pencil")
                    }
                }
            }
        }
        .animation(.easeInOut, value: controller.wordbook)
        .animation(.easeInOut, value: isEditing)
        .sheet(isPresented: $controller.isAddShown, content: { AddWordView(wordbook: controller.wordbook) })
        .sheet(isPresented: $controller.isDetailsShown) {
            DetailsView(wordbook: controller.wordbook, word: controller.selectedWord!)
        }
        .environmentObject(controller)
    }
}

//struct WordsView_Previews: PreviewProvider {
//    static var previews: some View {
//        WordsView(wordbooks: .constant([WordBooks(name: "System English Words", words: [], modifiedDate: Date())]), isNavBarHidden: .constant(false), wordbookId: UUID())
//    }
//}
