//
//  DetailsWordController.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/2/23.
//

import SwiftUI

class DetailsWordController: WordController {
    let word: Word
    
    @Published var isEditing = false
    
    init(wordbook: Wordbook, word: Word) {
        self.word = word
        
        super.init(wordbook: wordbook)
        self.originalWord = word.original
        self.translatedWord = word.translated
        self.synonyms = word.synonyms
        self.antonyms = word.antonyms
        self.examples = word.examples
        self.imageUrls = word.imageUrls
        self.imageSearchCount = word.imageSearchCount
        self.textGeneratedCount = word.textGeneratedCount
    }
    
    func updateWord(dismiss: DismissAction) {
        Task { @MainActor in
            isLoading = true
            defer {
                isLoading = false
            }
            
            do {
                try await
                wordbookService.updateWord(wordId: word.wordId, original: originalWord, translated: translatedWord,
                                           priority: word.priority, missed: word.missed, thumbnailUrl: word.thumbnailUrl, imageUrls: imageUrls,
                                           synonyms: synonyms, antonyms: antonyms, examples: examples,
                                           imageSearchCount: imageSearchCount, textGeneratedCount: textGeneratedCount, to: wordbook)
                dismiss()
            } catch {
                errorMessage = error.localizedDescription
                isErrorShown = true
                print(error)
            }
        }
    }
    
    func updateCountOnly() {
        Task { @MainActor in
            isLoading = true
            defer {
                isLoading = false
            }
            
            do {
                try await
                wordbookService.updateWord(wordId: word.wordId, original: word.original, translated: word.translated,
                                           priority: word.priority, missed: word.missed, thumbnailUrl: word.thumbnailUrl, imageUrls: word.imageUrls,
                                           synonyms: word.synonyms, antonyms: word.antonyms, examples: word.examples,
                                           imageSearchCount: imageSearchCount, textGeneratedCount: textGeneratedCount, to: wordbook)
            } catch {
                errorMessage = error.localizedDescription
                isErrorShown = true
                print(error)
            }
        }
    }
}
