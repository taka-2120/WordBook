//
//  WordsView.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/10/04.
//

import SwiftUI
import SwipeActions

struct WordsView: View {
    
    @StateObject private var controller: WordsController
    @State private var isEditShown = false
    
    init(wordbook: Wordbook, at index: Int) {
        _controller = StateObject(wrappedValue: WordsController(wordbook: wordbook, index: index))
    }
    
    var body: some View {
        ZStack {
            if controller.wordbook.words.isEmpty {
                VStack {
                    Spacer()
                    Image(systemName: "rectangle.portrait.on.rectangle.portrait.slash")
                        .symbolRenderingMode(.hierarchical)
                        .font(.system(size: 64))
                        .padding()
                    Text("noWords")
                        .font(.title3)
                        .bold()
                    Spacer()
                }
            } else {
                ScrollView {
                    VStack {
                        SwipeViewGroup {
                            ForEach(Array(controller.wordbook.words.enumerated()), id: \.offset) { index, word in
                                WordItem(word: word, index: index)
                            }
                        }
                        
                        if !controller.hasUnlimited && controller.wordbook.words.count == unlimitedMaxWordCount {
                            Button {
                                controller.isPlanViewShown = true
                            } label: {
                                HStack {
                                    Text("needUnlimitedWord")
                                        .font(.headline)
                                        .foregroundColor(Color(.label))
                                }
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding(.horizontal)
                                .padding(.vertical, 20)
                                .background(.regularMaterial)
                                .cornerRadius(15)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 15)
                                        .strokeBorder(.gray, style: StrokeStyle(lineWidth: 2, dash: [10]))
                                }
                            }
                            .padding()
                        }
                        
                        if !controller.hasUnlimited && controller.wordbook.words.count < unlimitedMaxWordCount {
                            HStack {
                                Spacer()
                                Text("limit: \(controller.wordbook.words.count)/\(unlimitedMaxWordCount)")
                                    .foregroundColor(Color(.secondaryLabel))
                                    .font(.callout)
                            }
                            .padding()
                        }
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 70)
                }
            }
            
            if !controller.wordbook.words.isEmpty {
                VStack(alignment: .trailing) {
                    Spacer()
                    
                    Menu {
                        Button {
                            controller.isTestShown.toggle()
                        } label: {
                            Label("testMode", systemImage: "list.bullet.clipboard")
                        }
                        Button {
                            controller.isFlashCardShown.toggle()
                        } label: {
                            Label("flashCard", systemImage: "rectangle.portrait.on.rectangle.portrait.angled.fill")
                        }
                    } label: {
                        Image(systemName: "play.fill")
                            .imageScale(.large)
                            .padding()
                    }
                    .background {
                        Circle()
                            .fill(.thickMaterial)
                            .cornerRadius(100)
                            .shadow(color: .black.opacity(0.2), radius: 15, y: 3)
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                .padding()
            }
        }
        .background(Color(.secondarySystemBackground))
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.browser)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Button {
                    isEditShown.toggle()
                } label: {
                    HStack {
                        Text(controller.wordbook.name)
                            .foregroundStyle(Color(.label))
                            .padding(8)
                            .cornerRadius(10)
                            .frame(maxWidth: 250)
                        
                        Label("edit", systemImage: "pencil")
                            .foregroundStyle(Color(.secondaryLabel))
                            .imageScale(.small)
                    }
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                HStack(spacing: 0) {
                    Menu {
                        Toggle(isOn: $controller.isMissedCountChecked) {
                            Label("missedCount", systemImage: "exclamationmark.transmission")
                        }
                        .onChange(of: controller.isMissedCountChecked) { _ in
                            controller.updateWordItemVisibilities()
                        }
                        Toggle(isOn: $controller.isPriorityChecked) {
                            Label("priority", systemImage: "sprinkler.fill")
                        }
                        .onChange(of: controller.isPriorityChecked) { _ in
                            controller.updateWordItemVisibilities()
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }

                    Button {
                        controller.isAddShown.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .animation(.easeInOut, value: controller.wordbook)
        .animation(.bouncy, value: controller.isPriorityChecked)
        .animation(.bouncy, value: controller.isMissedCountChecked)
        .fullScreenCover(isPresented: $controller.isTestShown) {
            TestModeView()
        }
        .fullScreenCover(isPresented: $controller.isFlashCardShown) {
            FlashCardMode()
        }
        .sheet(isPresented: $controller.isAddShown) {
            AddWordView(wordbook: controller.wordbook)
        }
        .sheet(isPresented: $controller.isDetailsShown) {
            DetailsView(wordbook: controller.wordbook, word: controller.selectedWord!)
        }
        .sheet(isPresented: $controller.isPlanViewShown) {
            PlansView()
                .padding(.top, 20)
        }
        .sheet(isPresented: $isEditShown) {
            WordEditView()
                .presentationDetents([.medium])
                .interactiveDismissDisabled()
        }
        .alert("error", isPresented: $controller.isErrorShown) {
            Text("OK")
        } message: {
            Text(controller.errorMessage)
        }
        .environmentObject(controller)
    }
}

fileprivate struct WordEditView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var controller: WordsController
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                
                CustomField("wordbookTitle", placeHolder: "wordbookTitle", text: $controller.wordbookTitle)
                
                ColorPicker("color", selection: $controller.wordbookColor)
                    .padding([.leading, .top])
                
                Spacer()
            }
            .padding()
            .alert("error", isPresented: $controller.isErrorShown) {
                Text("OK")
            } message: {
                Text(controller.errorMessage)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("cancel")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if controller.wordbookTitle.isEmpty {
                            controller.errorMessage = "fillTitle"
                            controller.isErrorShown = true
                        } else {
                            controller.updateWordbook()
                            dismiss()
                        }
                    } label: {
                        Text("save")
                    }
                }
            }
        }
    }
}
