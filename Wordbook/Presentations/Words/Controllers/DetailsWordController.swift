//
//  DetailsWordController.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/2/23.
//

import SwiftUI

class DetailsWordController: ObservableObject {
    private let wordbookService = WordbookService()
    let wordbook: Wordbook
    let word: Word
    
    @Published var originalWord = ""
    @Published var translatedWord = ""
    @Published var synonyms = [String]()
    @Published var antonyms = [String]()
    @Published var examples = [String]()
    
    init(wordbook: Wordbook, word: Word) {
        self.wordbook = wordbook
        self.word = word
        self.originalWord = word.original
        self.translatedWord = word.translated
        self.synonyms = word.synonyms
        self.antonyms = word.antonyms
        self.examples = word.examples
    }
    
    func updateWord(dismiss: DismissAction) {
        Task { @MainActor in
            do {
                try await
                wordbookService.updateWord(wordId: word.wordId, original: originalWord, translated: translatedWord, priority: word.priority, missed: word.missed, synonyms: synonyms, antonyms: antonyms, examples: examples, to: wordbook)
                dismiss()
            } catch {
                print(error)
            }
        }
    }
    
    func generateAll() {
        Task { @MainActor in
            do {
                synonyms = try await fetchGPTResult(for: originalWord, mode: .synonyms) ?? []
                antonyms = try await fetchGPTResult(for: originalWord, mode: .antonyms) ?? []
                examples = try await fetchGPTResult(for: originalWord, mode: .examples) ?? []
            } catch {
                print(error)
            }
        }
    }
}
