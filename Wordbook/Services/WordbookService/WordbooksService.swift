//
//  WordbooksService.swift
//  WordBook
//
//  Created by Yu Takahashi on 3/28/23.
//

import Foundation

class WordbookService {
    
    private let wordbookRepo = WordbookRepo.shared
    private let authRepo = SupabaseAuthRepo.shared
    
    func getWordbooks() -> [Wordbook] {
        wordbookRepo.wordbooks
    }
    
    func addWordbook(name: String, color: String) async throws {
        if let id = authRepo.session?.user.id {
            try await wordbookRepo.insertWordbook(userId: id, name: name, color: color)
        } else {
            print("Session Expired")
        }
    }
    
    func fetchWordbook() async throws {
        if let id = authRepo.session?.user.id {
            try await wordbookRepo.fetchWordbook(userId: id)
        } else {
            print("Session Expired")
        }
    }
    
    func removeWordbook(at index: Int) {
//        wordbooks.remove(at: index)
    }
    
    func getSameWordbook(current wordbook: Wordbook) {
//        let wordbookIndex = wordbooks.lastIndex(where: { $0.id == wordbook.id })
//        guard let wordbookIndex = wordbookIndex else {
//            // TODO: Handle Error
//            print("No Wordbook")
//            return wordbooks[0]
//        }
//        return wordbooks[wordbookIndex]
    }
    
    func addWord(original: String, translated: String, priority: Int,
                 missed: Int, synonyms: [String], antonyms: [String], examples: [String], to wordbook: Wordbook) async throws {
        if let id = authRepo.session?.user.id {
            try await wordbookRepo.insertWord(userId: id, bookId: wordbook.bookId , original: original, translated: translated, priority: priority, missed: missed, synonyms: synonyms, antonyms: antonyms, examples: examples)
        } else {
            print("Session Expired")
        }
    }
    
    func updateWord(word: Word, in wordbook: Wordbook) {
//        let wordbookIndex = wordbooks.lastIndex(where: { $0.id == wordbook.id })
//        guard let wordbookIndex = wordbookIndex else {
//            // TODO: Handle Error
//            print("No Wordbook")
//            return
//        }
//
//        let wordIndex = wordbook.words.lastIndex(where: { $0.id == word.id })
//        guard let wordIndex = wordIndex else {
//            // TODO: Handle Error
//            print("No Word")
//            return
//        }
//        wordbooks[wordbookIndex].words[wordIndex] = word
    }
}
