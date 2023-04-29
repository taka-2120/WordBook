//
//  ContentView.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/09/30.
//

import SwiftUI
import SwipeActions

struct WordbooksView: View {
    @ObservedObject private var controller = WordbooksController()
    @State private var wordbookPathes: [Wordbook] = []
    
    var body: some View {
        NavigationStack(path: $wordbookPathes) {
            ScrollView {
                SwipeViewGroup {
                    ForEach(Array(controller.wordbooks.enumerated()), id: \.offset) { index, wordbook in
                        WordbookItem(wordbook: wordbook, index: index)
                    }
                }
            }
            .navigationTitle("Wordbooks")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: Wordbook.self) { wordbook in
                WordsView(wordbook: wordbook)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        controller.isSettingsShown.toggle()
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        controller.isAddShown.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $controller.isAddShown, content: { AddWordbookView() })
            .sheet(isPresented: $controller.isSettingsShown, content: { SettingsView() })
            .onChange(of: wordbookPathes) { newValue in
                if newValue == [] {
                    controller.getWordbooks()
                }
            }
            .animation(.easeInOut, value: controller.wordbooks)
        }
        .environmentObject(controller)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WordbooksView()
    }
}
