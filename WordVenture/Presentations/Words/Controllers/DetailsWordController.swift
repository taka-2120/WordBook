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
    @Published var isLoading = false
    @Published var isGenerating = false
    @Published var imageUrls = [String]()
    
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    
    init(wordbook: Wordbook, word: Word) {
        self.wordbook = wordbook
        self.word = word
        self.originalWord = word.original
        self.translatedWord = word.translated
        self.synonyms = word.synonyms
        self.antonyms = word.antonyms
        self.examples = word.examples
        self.imageUrls = word.imageUrls
    }
    
    func updateWord(dismiss: DismissAction) {
        Task { @MainActor in
            do {
                try await
                wordbookService.updateWord(wordId: word.wordId, original: originalWord, translated: translatedWord,
                                           priority: word.priority, missed: word.missed, thumbnailUrl: "", imageUrls: imageUrls,
                                           synonyms: synonyms, antonyms: antonyms, examples: examples, to: wordbook)
                dismiss()
            } catch {
                errorMessage = error.localizedDescription
                isErrorShown = true
                print(error)
            }
        }
    }
    
    func generateImages() {
        Task { @MainActor in
            do {
                imageUrls = try await fetchUnsplashPhotos(for: originalWord)
            } catch {
                errorMessage = error.localizedDescription
                isErrorShown = true
                print(error)
            }
        }
    }
    
    func generateAll() {
        Task { @MainActor in
            isGenerating = true
            do {
                synonyms = try await fetchGPTResult(for: originalWord, mode: .synonyms) ?? []
                antonyms = try await fetchGPTResult(for: originalWord, mode: .antonyms) ?? []
                examples = try await fetchGPTResult(for: originalWord, mode: .examples) ?? []
            } catch {
                errorMessage = error.localizedDescription
                isErrorShown = true
                print(error)
            }
            isGenerating = false
        }
    }
}
