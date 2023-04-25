//
//  WordbooksService.swift
//  WordBook
//
//  Created by Yu Takahashi on 3/28/23.
//

import Foundation

class WordbookService {
    static let shared = WordbookService()
    private init () {}
    
    var wordbooks: [Wordbook] = wordbooksMock
    
    func addWordbook(newWordbook: Wordbook) {
        wordbooks.append(newWordbook)
    }
    
    func removeWordbook(at index: Int) {
        wordbooks.remove(at: index)
    }
    
    func getSameWordbook(current wordbook: Wordbook) -> Wordbook {
        let wordbookIndex = wordbooks.lastIndex(where: { $0.id == wordbook.id })
        guard let wordbookIndex = wordbookIndex else {
            // TODO: Handle Error
            print("No Wordbook")
            return wordbooks[0]
        }
        return wordbooks[wordbookIndex]
    }
    
    func addWord(newWord: Word, to wordbook: Wordbook) {
        let wordbookIndex = wordbooks.lastIndex(where: { $0.id == wordbook.id })
        guard let wordbookIndex = wordbookIndex else {
            // TODO: Handle Error
            print("No Wordbook")
            return
        }
        wordbooks[wordbookIndex].words.append(newWord)
    }
    
    func updateWord(word: Word, in wordbook: Wordbook) {
        let wordbookIndex = wordbooks.lastIndex(where: { $0.id == wordbook.id })
        guard let wordbookIndex = wordbookIndex else {
            // TODO: Handle Error
            print("No Wordbook")
            return
        }
        
        let wordIndex = wordbook.words.lastIndex(where: { $0.id == word.id })
        guard let wordIndex = wordIndex else {
            // TODO: Handle Error
            print("No Word")
            return
        }
        wordbooks[wordbookIndex].words[wordIndex] = word
    }
}
