//
//  DetailsWordController.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/2/23.
//

import SwiftUI

class DetailsWordController: WordController, ObservableObject {
    let word: Word
    
    init(wordbook: Wordbook, word: Word) {
        self.word = word
        
        super.init(wordbook: wordbook)
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
}
