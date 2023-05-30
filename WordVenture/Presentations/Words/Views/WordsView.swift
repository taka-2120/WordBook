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

struct WordsView: View {
    @StateObject private var controller: WordsController
    @State private var isEditing = false
    
    init(wordbook: Wordbook) {
        _controller = StateObject(wrappedValue: WordsController(wordbook: wordbook))
    }
    
    var body: some View {
        ZStack {
            if controller.wordbook.words.isEmpty {
                VStack {
                    Image(systemName: "rectangle.portrait.on.rectangle.portrait.slash")
                        .symbolRenderingMode(.hierarchical)
                        .font(.system(size: 64))
                        .padding()
                    Text("noWords")
                        .font(.title3)
                        .bold()
                }
            } else {
                ScrollView {
                    SwipeViewGroup {
                        ForEach(Array(controller.wordbook.words.enumerated()), id: \.offset) { index, word in
                            WordItem(word: word, index: index)
                        }
                        .padding(.top, 30)
                    }
                }
            }
            
            if isEditing {
                Rectangle()
                    .fill(Color(.systemBackground).opacity(0.2))
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .onTapGesture {
                        isEditing = false
                    }
            }
            
            if !controller.wordbook.words.isEmpty {
                VStack(alignment: .trailing) {
                    Spacer()
                    
                    NavigationLink {
                        CardMode()
                            .environmentObject(controller)
                    } label: {
                        Image(systemName: "play.fill")
                            .padding()
                    }
                    .id(UUID())
                    .background(.thickMaterial)
                    .cornerRadius(100)
                    .shadow(color: .black.opacity(0.2), radius: 15, y: 3)
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.browser)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    ColorPicker("", selection: $controller.wordbookColor)
                        .scaleEffect(0.7)
                        .frame(width: 25, height: 25)
                    
                    TextField("wordbookTitle", text: $controller.wordbookTitle)
                        .padding(8)
                        .background(isEditing ? Color(.secondarySystemBackground) : .clear)
                        .cornerRadius(10)
                        .disabled(!isEditing)
                        .frame(minWidth: 0, maxWidth: 130, alignment: .center)
                    
                    Menu {
                        if !isEditing {
                            Button {
                                isEditing = true
                            } label: {
                                Label("rename", systemImage: "pencil")
                            }
                        }
                    } label: {
                        Image(systemName: "chevron.down.circle.fill")
                            .foregroundColor(Color(.secondaryLabel))
                            .imageScale(.small)
                    }
                    .disabled(isEditing)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                if isEditing {
                    Button {
                        controller.updateWordbook()
                        isEditing = false
                    } label: {
                        Text("done")
                    }
                } else {
                    Button {
                        controller.isAddShown = true
                    } label: {
                        Image(systemName: "plus")
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
        .alert("error", isPresented: $controller.isErrorShown) {
            Text("OK")
        } message: {
            Text(controller.errorMessage)
        }
    }
}

//struct WordsView_Previews: PreviewProvider {
//    static var previews: some View {
//        WordsView(wordbooks: .constant([WordBooks(name: "System English Words", words: [], modifiedDate: Date())]), isNavBarHidden: .constant(false), wordbookId: UUID())
//    }
//}
