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
    @State private var color = Color.clear
    @State private var isColorPickerShown = false
    
    init(wordbook: Wordbook) {
        self.controller = WordsController(wordbook: wordbook)
        self.color = Color(hex: controller.wordbook.color)
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                SwipeViewGroup {
                    ForEach(controller.wordbook.words, id: \.id) { word in
                        WordItem(word: word)
                    }
                }
                .padding(.top, 30)
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
                    TextField("Wordbook Title", text: $controller.wordbook.name)
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
                        isEditing = false
                    } label: {
                        Text("Done")
                    }
                } else {
                    Button {
                        controller.isAddShown.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            
            ToolbarTitleMenu {
                if !isEditing {
                    Button {
                        isEditing = true
                    } label: {
                        Label("Rename", systemImage: "pencil")
                    }
                    
                    // TODO: Enable CHanging Color
                    Button {
                        isColorPickerShown = true
                    } label: {
                        Label("Change Color", systemImage: "palette")
                    }
                    .disabled(true)
                }
            }
        }
        .animation(.easeInOut, value: controller.wordbook)
        .animation(.easeInOut, value: isEditing)
        .sheet(isPresented: $controller.isAddShown, content: { AddWordView(wordbook: controller.wordbook) })
        .sheet(isPresented: $controller.isDetailsShown) {
            DetailsView(wordbook: controller.wordbook, word: controller.selectedWord!)
        }
        .presentableColorPicker(isPresented: $isColorPickerShown, selection: $color)
        .environmentObject(controller)
    }
}

//struct WordsView_Previews: PreviewProvider {
//    static var previews: some View {
//        WordsView(wordbooks: .constant([WordBooks(name: "System English Words", words: [], modifiedDate: Date())]), isNavBarHidden: .constant(false), wordbookId: UUID())
//    }
//}
