//
//  TestCardItem.swift
//  WordVenture
//
//  Created by Yu Takahashi on 7/8/23.
//

import SwiftUI
import SwiftUIPager

struct TestCardItem: View {
    
    @EnvironmentObject private var controller: WordsController
    @EnvironmentObject private var testCardController: TestCardController
    @EnvironmentObject private var page: Page
    
    @State private var selectedPriority: Priority
    @Binding private var isImageShown: Bool
    
    private let word: Word
    private let geo: GeometryProxy
    
    init(word: Word, isImageShown: Binding<Bool>, geo: GeometryProxy) {
        self.word = word
        self.geo = geo
        self._isImageShown = isImageShown
        self._selectedPriority = State(initialValue: word.priority.toPriority())
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
            Spacer()
            VStack {
                Text(word.original)
                if !isFront {
                    Divider()
                        .padding()
                    Text(word.translated)
                }
            }
            .font(.title)
            .fontWeight(.bold)
            
            Spacer()
            
            if isFront {
                ImageSection
            } else {
                VStack(alignment: .trailing, spacing: 20) {
                    Button {
                        
                    } label: {
                        VStack {
                            Image(systemName: "arrow.counterclockwise")
                            Text("retry")
                                .font(.callout)
                                .foregroundStyle(Color(.secondaryLabel))
                        }
                    }
                    
                    HStack {
                        Text("missedCount") + Text(": \(word.missed)")
                        Spacer()
                        Button {
                            testCardController.isPrioritySheetShown.toggle()
                        } label: {
                            HStack {
                                Text("priority")
                                    .foregroundStyle(Color(.secondaryLabel))
                                    .font(.callout)
                                Image(systemName: selectedPriority.symbol)
                                    .foregroundStyle(selectedPriority.color)
                            }
                        }
                    }
                    .padding(.bottom, 25)
                    
                    HStack {
                        Button {
                            withAnimation {
                                feedbackGenerator(type: .error)
                                testCardController.isMissedShown.toggle()
                            }
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.red)
                                .font(.system(size: 28))
                        }
                        Spacer()
                        Button {
                            withAnimation {
                                feedbackGenerator(type: .success)
                                page.update(.next)
                            }
                        } label: {
                            Image(systemName: "circle.circle.fill")
                                .foregroundStyle(.green)
                                .font(.system(size: 28))
                        }
                    }
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .sheet(isPresented: $testCardController.isPrioritySheetShown) {
            controller.updatePriority(for: word, priority: selectedPriority)
        } content: {
            PriorityView(selectedPriority: $selectedPriority)
                .presentationDetents([.medium])
        }
    }
    
    private var ImageSection: some View {
        Group {
            if let url = word.imageUrls.first, isImageShown {
                Divider()
                RelatedImage(url: url, height: 200)
            }
        }
    }
}
