//
//  WordItem.swift
//  WordBook
//
//  Created by Yu Takahashi on 2022/07/03.
//

import Combine
import SwiftUI
import SwipeActions
import NukeUI
import Nuke

struct WordItem: View {
    @EnvironmentObject private var controller: WordsController
    @State private var close = PassthroughSubject<Void, Never>()
    @State private var isDeletePromptShown = false
    
    private let word: Word
    private let index: Int
    
    init( word: Word, index: Int) {
        self.word = word
        self.index = index
    }
    
    var body: some View {
        SwipeView {
            Button {
                controller.selectWord(for: word)
                controller.isDetailsShown.toggle()
            } label: {
                HStack {
                    if controller.isMissedCountChecked {
                        Text("\(word.missed)")
                            .font(.caption)
                            .foregroundStyle(Color(.label))
                            .background {
                                Circle()
                                    .fill(Color(.systemGray3))
                                    .frame(width: 25, height: 25)
                            }
                            .padding(.horizontal, 8)
                    }
                    
                    Text(word.original)
                        .font(.headline)
                        .foregroundColor(Color(.label))
                    
                    Spacer()
                    
                    Text("\(word.translated)")
                        .font(.subheadline)
                        .foregroundColor(Color(.secondaryLabel))
                    
                    if controller.isPriorityChecked {
                        Image(systemName: word.priority.toPriority().symbol)
                            .foregroundStyle(word.priority.toPriority().color)
                            .imageScale(.small)
                            .isHidden(word.priority.toPriority() == .no, remove: true)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 20)
                .background(Color(.tertiarySystemBackground).opacity(0.8))
                .cornerRadius(15)
                .contextMenu {
                    Button {
                        controller.selectedWord = word
                        controller.isDetailsShown.toggle()
                    } label: {
                        Label("edit", systemImage: "square.and.pencil")
                    }
                } preview: {
                    if !word.imageUrls.isEmpty || !word.thumbnailUrl.isEmpty {
                        let url = word.thumbnailUrl.isEmpty ? word.imageUrls.first! : word.thumbnailUrl
                        
                        ZStack(alignment: .bottomTrailing) {
                            LazyImage(url: URL(string: url)!) { state in
                                if let image = state.image {
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } else if state.error != nil {
                                    VStack {
                                        Spacer()
                                        Image(systemName: "xmark.fill")
                                            .font(.system(size: 32))
                                            .foregroundStyle(.red)
                                        Spacer()
                                    }
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .frame(height: 250)
                                    .background(Color(.systemBackground))
                                } else {
                                    ProgressView()
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .frame(height: 250)
                                        .background(Color(.systemBackground))
                                }
                            }
                            .pipeline(customPipeline)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            
                            VStack(spacing: 10) {
                                Text(word.original)
                                    .foregroundStyle(Color(.label))
                                Text(word.translated)
                                    .foregroundStyle(Color(.secondaryLabel))
                            }
                            .padding(.vertical)
                            .padding(.horizontal, 20)
                            .background(.regularMaterial.opacity(0.8))
                            .cornerRadius(15)
                            .padding(10)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .onTapGesture {
                            controller.selectedWord = word
                            controller.isDetailsShown.toggle()
                        }
                    }
                }
                .shadow(color: .black.opacity(0.1), radius: 10, y: 2)
            }

//        } leadingActions: { context in
//            SwipeAction(systemImage: "pin") {
//                controller.pinWordbook()
//            }
//            .background(.orange)
//            .foregroundColor(.white)
        } trailingActions: { context in
            SwipeAction(systemImage: "square.and.pencil") {
                controller.selectWord(for: word)
                controller.isDetailsShown.toggle()
            }
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(15)
            
            SwipeAction(systemImage: "trash") {
                isDeletePromptShown.toggle()
            }
            .allowSwipeToTrigger()
            .background(.red)
            .foregroundColor(.white)
            .onReceive(close) { _ in /// Receive the `PassthroughSubject`.
                context.state.wrappedValue = .closed
            }
        }
        .swipeActionWidth(80)
        .swipeActionCornerRadius(15)
        .swipeActionsMaskCornerRadius(15)
        .swipeEnableTriggerHaptics(true)
        .padding(.horizontal)
        .padding(.vertical, 5)
        .alert("deleteWordWarning", isPresented: $isDeletePromptShown) {
            Button(role: .destructive) {
                controller.removeWord(at: index)
                close.send()
            } label: {
                Text("delete")
            }
            Button(role: .cancel) {
                close.send()
            } label: {
                Text("cancel")
            }
        }
    }
}
