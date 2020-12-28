//
//  WordsView.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/10/04.
//

import SwiftUI
import VisionKit
import Vision

struct WordsView: View {
    
    @Binding var wordbooks: [Wordbooks]
    @Binding var isNavBarHidden: Bool
    var wordbookId: UUID
    
    @Environment(\.presentationMode) var presentationMode
    @State var editMode = EditMode.inactive
    @State var addViewShown = false
    @State var cardViewShown = false
    @State var editingViewShown = false
    @State var words: [Words] = []
    @State var wordbookIndex = 0
    @State var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State var shown = false
    @State var detectorIsShown = false
    
    var body: some View {
        
        ZStack {
            NavigationLink("", destination: CardMode(wordbooks: $wordbooks, wordbookIndex: $wordbookIndex, words: $words, isNavBarHidden: $isNavBarHidden), isActive: $cardViewShown)
                .hidden()
            
            List {
                Section {
                    HStack {
                        HStack {
                            Spacer()
                            Image(systemName: "plus")
                                .onTapGesture {
                                    detectorIsShown = true
                                }
                                .sheet(isPresented: $detectorIsShown, content: {
                                    ImportMethodView(wordbooks: $wordbooks, words: $words, wordbookIndex: $wordbookIndex)
                                })
                            Spacer()
                        }
                        Spacer()
                        HStack {
                            Spacer()
                            Image(systemName: "arrowtriangle.right.fill")
                                .onTapGesture {
                                    shown = true
                                    isNavBarHidden = true
                                    cardViewShown = true
                                }
                            Spacer()
                        }
                    }
                    Text("\(words.count) word\(countWord())")
                }
                
                ForEach(words, id: \.id) { word in
                    Button(action: {
                        shown = true
                        editingViewShown = true
                    }, label: {
                        HStack {
                            Circle()
                                .fill(priorityDetector(priority: word.priority))
                                .frame(maxWidth: 10, maxHeight: 10)
                            Text(word.originalWord)
                                .foregroundColor(Color(.label))
                            Spacer()
                            Text(word.translatedWord)
                                .foregroundColor(Color(.secondaryLabel))
                        }
                    })
                    .contextMenu {
                        Button(action: {
                            editingViewShown = true
                        }) {
                            Text("Edit")
                            Image(systemName: "square.and.pencil")
                        }

                        Button(action: {
                            for i in 0 ... words.count {
                                if words[i].id == word.id {
                                    words.remove(at: i)
                                    wordbooks[wordbookIndex].words.remove(at: i)
                                    return
                                }
                            }
                        }) {
                            Text("Delete")
                            Image(systemName: "trash")
                        }
                        .foregroundColor(Color(.systemRed))
                    }
                    .sheet(isPresented: $editingViewShown) {
                        EditingView(originalWord: word.originalWord, translatedWord: word.translatedWord, priority: word.priority, missed: word.missed, wordId: word.id, wordbookIndex: $wordbookIndex, wordbooks: $wordbooks, words: $words)
                    }
                }
                .onMove(perform: { indices, newOffset in
                    words.move(fromOffsets: indices, toOffset: newOffset)
                    wordbooks[wordbookIndex].words.move(fromOffsets: indices, toOffset: newOffset)
                })
                .onDelete(perform: { indexSet in
                    words.remove(atOffsets: indexSet)
                    wordbooks[wordbookIndex].words.remove(atOffsets: indexSet)
                })
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(Text("Words"))
            .navigationBarItems(trailing: EditButton().foregroundColor(Color(.label)))
            .environment(\.editMode, $editMode)
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(isNavBarHidden)
        .onAppear() {
            if shown == false {
                for i in 0 ... wordbooks.count - 1 {
                    if wordbooks[i].id == wordbookId {
                        words = wordbooks[i].words
                        wordbookIndex = i
                    }
                }
            }
        }
    }
    
    func countWord() -> String {
        if words.count == 1 {
            return ""
        } else {
            return "s"
        }
    }
    
    func priorityDetector(priority: Int) -> Color {
        switch priority {
        case 0: return Color.clear
        case 1: return Color(.systemBlue)
        case 2: return Color(.systemOrange)
        case 3: return Color(.systemRed)
        default: return Color.clear
        }
    }
}
