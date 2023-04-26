//
//  DetailsWordController.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/2/23.
//

import Foundation

class DetailsWordController: ObservableObject {
    private let wordbooksService = WordbookService()
    let wordbook: Wordbook
    let word: Word
    
    @Published var originalWord = ""
    @Published var translatedWord = ""
    
    init(wordbook: Wordbook, word: Word) {
        self.wordbook = wordbook
        self.word = word
        originalWord = word.original
        translatedWord = word.translated
    }
    
    func updateWord() {
        var word = word
        word.original = originalWord
        word.translated = translatedWord
        wordbooksService.updateWord(word: word, in: wordbook)
    }
}
