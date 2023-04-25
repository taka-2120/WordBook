//
//  AddWordController.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/2/23.
//

import Foundation

class AddWordController: ObservableObject {
    private let wordbooksService = WordbookService.shared
    let wordbook: Wordbook
    
    @Published var originalWord = ""
    @Published var translatedWord = ""
    @Published var synonyms = [String]()
    @Published var antonyms = [String]()
    @Published var examples = [String]()
    
    init(wordbook: Wordbook) {
        self.wordbook = wordbook
    }
    
    func addWord() {
        var word = Word(
            bookId: UUID(),
            original: originalWord,
            translated: translatedWord,
            priority: 0,
            missed: 0,
            synonyms: synonyms,
            antonyms: antonyms,
            examples: examples)
        word.original = originalWord
        word.translated = translatedWord
        wordbooksService.updateWord(word: word, in: wordbook)
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
