//
//  WordsController.swift
//  WordBook
//
//  Created by Yu Takahashi on 3/28/23.
//

import SwiftUI

class WordsController: ObservableObject {
    private let wordbookService = WordbookService()
    @Published var wordbook: Wordbook
    @Published var selectedWord: Word? = nil
    
    @Published var editMode = EditMode.inactive
    @Published var isAddShown = false {
        willSet {
            if newValue == false && wordbookIndex != nil {
                wordbook = wordbookService.getWordbooks()[wordbookIndex!]
            }
        }
    }
    @Published var isDetailsShown = false {
        willSet {
            if newValue == false && wordbookIndex != nil {
                wordbook = wordbookService.getWordbooks()[wordbookIndex!]
            }
        }
    }
    @Published var cardViewShown = false
    @Published var wordbookIndex: Int? = nil
    @Published var wordbookTitle = ""
    @Published var wordbookColor = Color.blue {
        willSet {
            updateWordbook()
        }
    }
    
    init(wordbook: Wordbook) {
        self.wordbook = wordbook
        self.wordbookIndex = wordbookService.getWordbooks().firstIndex(of: wordbook)
        self.wordbookTitle = wordbook.name
        self.wordbookColor = Color(hex: wordbook.color)
    }
    
    func updateTitle() {
        updateWordbook()
    }
    
    private func updateWordbook() {
        Task { @MainActor in
            do {
                try await wordbookService.updateWordbook(bookId: wordbook.bookId, name: wordbookTitle, color: wordbookColor.toHex())
            } catch {
                print(error)
            }
        }
    }
    
    private func getWordbook() {
        wordbook = wordbookService.getWordbooks()[wordbookIndex!]
    }
    
    func selectWord(for word: Word) {
        selectedWord = word
    }
    
    func removeWord(at index: Int) {
        Task { @MainActor in
            let cache = wordbook.words[index]
            do {
                wordbook.words.remove(at: index)
                try await wordbookService.removeWord(for: wordbook, at: index)
                getWordbook()
            } catch {
                print(error)
                wordbook.words.insert(cache, at: index)
            }
        }
    }
}
