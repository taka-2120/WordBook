//
//  WordController.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/3/23.
//

import SwiftUI

class WordController: ObservableObject {
    let wordbookService = WordbookService()
    private let openAIUseCase = OpenAIUseCase()
    private let unsplashUseCase = UnsplashUseCase()
    var wordbook: Wordbook
    
    @Published var originalWord = ""
    @Published var translatedWord = ""
    @Published var synonyms = [String]()
    @Published var antonyms = [String]()
    @Published var examples = [String]()
    @Published var isLoading = false
    @Published var isGenerating = false
    @Published var imageUrls = [String]()
    @Published var isImageNotFound = false
    
    @Published var imageSearchCount = 0
    @Published var textGeneratedCount = 0
    
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    
    init(wordbook: Wordbook) {
        self.wordbook = wordbook
    }
    
    func generateImages() {
        Task { @MainActor in
            do {
                imageUrls = try await unsplashUseCase.fetchUnsplashImageUrls(for: originalWord)
                
                isImageNotFound = imageUrls.isEmpty
                if !isImageNotFound {
                    imageSearchCount += 1
                }
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
                synonyms = try await openAIUseCase.fetchGeneratedText(for: originalWord, mode: .synonyms) ?? []
                antonyms = try await openAIUseCase.fetchGeneratedText(for: originalWord, mode: .antonyms) ?? []
                examples = try await openAIUseCase.fetchGeneratedText(for: originalWord, mode: .examples) ?? []
                textGeneratedCount += 1
            } catch {
                errorMessage = error.localizedDescription
                isErrorShown = true
                print(error)
            }
            isGenerating = false
        }
    }
}

