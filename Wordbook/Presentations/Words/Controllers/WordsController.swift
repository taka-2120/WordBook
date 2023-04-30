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
    
    init(wordbook: Wordbook) {
        self.wordbook = wordbook
        self.wordbookIndex = wordbookService.getWordbooks().firstIndex(of: wordbook)
        self.wordbookTitle = wordbook.name
    }
    
    func updateTitle() {
        Task { @MainActor in
            do {
                try await wordbookService.updateWordbook(bookId: wordbook.bookId, name: wordbookTitle, color: wordbook.color)
            } catch {
                print(error)
            }
        }
    }
    
    func selectWord(for word: Word) {
        selectedWord = word
    }
    
    func removeWord(at index: Int) {
        Task { @MainActor in
            do {
                try await wordbookService.removeWord(for: wordbook, at: index)
            } catch {
                print(error)
            }
        }
    }
}
