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
            fetchWordbook()
        }
    }
    @Published var isDetailsShown = false {
        willSet {
            fetchWordbook()
        }
    }
    @Published var cardViewShown = false
    @Published var wordbookIndex: Int
    @Published var wordbookTitle = ""
    @Published var wordbookColor = Color.blue {
        willSet {
            updateWordbook()
        }
    }
    
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    
    init(wordbook: Wordbook, index: Int) {
        self.wordbook = wordbook
        self.wordbookIndex = index
        self.wordbookTitle = wordbook.name
        self.wordbookColor = Color(hex: wordbook.color)
    }
    
    func updateWordbook() {
        Task { @MainActor in
            do {
                wordbook = try await wordbookService.updateWordbook(bookId: wordbook.bookId, name: wordbookTitle, color: wordbookColor.toHex(), original: nil, translated: nil)[wordbookIndex]
            } catch {
                print(error)
            }
        }
    }
    
    private func fetchWordbook() {
        Task { @MainActor in
            do {
                wordbook = try await wordbookService.fetchWordbook()[wordbookIndex]
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
            let word = wordbook.words[index]
            do {
                wordbook.words.remove(at: index)
                try await wordbookService.removeWord(for: wordbook, target: word.wordId)
                fetchWordbook()
            } catch {
                print(error)
                wordbook.words.insert(word, at: index)
            }
        }
    }
}
