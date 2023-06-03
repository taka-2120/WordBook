//
//  AddWordController.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/2/23.
//

import SwiftUI

class AddWordController: ObservableObject {
    private let wordbookService = WordbookService()
    let wordbook: Wordbook
    
    @Published var originalWord = ""
    @Published var translatedWord = ""
    @Published var synonyms = [String]()
    @Published var antonyms = [String]()
    @Published var examples = [String]()
    @Published var isLoading = false
    @Published var isGenerating = false
    @Published var imageUrls = [String]()
    @Published var isImageSearched = false
    
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    
    init(wordbook: Wordbook) {
        self.wordbook = wordbook
    }
    
    func addWord(_ dismiss: DismissAction) {
        Task { @MainActor in
            isLoading = true
            defer {
                isLoading = false
            }
            
            do {
                try await wordbookService.addWord(original: originalWord, translated: translatedWord,
                                                  priority: 0, missed: 0, thumbnailUrl: "", imageUrls: imageUrls,
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
