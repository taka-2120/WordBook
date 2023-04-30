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
    
    func fetchWordbook() async throws {
        if let id = authRepo.session?.user.id {
            try await wordbookRepo.fetchWordbook(userId: id)
        } else {
            print("Session Expired")
        }
    }
    
    
    func addWordbook(name: String, color: String) async throws {
        if let id = authRepo.session?.user.id {
            try await wordbookRepo.insertWordbook(userId: id, name: name, color: color)
        } else {
            print("Session Expired")
        }
    }
    
    func updateWordbook(bookId: UUID, name: String, color: String) async throws {
        if let id = authRepo.session?.user.id {
            try await wordbookRepo.updateWordbook(bookId: bookId, userId: id, name: name, color: color)
        } else {
            print("Session Expired")
        }
    }
    
    func removeWordbook(at index: Int) async throws {
        if let id = authRepo.session?.user.id {
            try await wordbookRepo.removeWordbook(userId: id, at: index)
        } else {
            print("Session Expired")
        }
    }
    
    
    func addWord(original: String, translated: String, priority: Int, missed: Int,
                 synonyms: [String], antonyms: [String], examples: [String], to wordbook: Wordbook) async throws {
        if let id = authRepo.session?.user.id {
            try await wordbookRepo.insertWord(userId: id, bookId: wordbook.bookId, original: original, translated: translated,
                                              priority: priority, missed: missed, synonyms: synonyms, antonyms: antonyms, examples: examples)
        } else {
            print("Session Expired")
        }
    }
    
    func updateWord(wordId: UUID, original: String, translated: String, priority: Int, missed: Int,
                    synonyms: [String], antonyms: [String], examples: [String], to wordbook: Wordbook) async throws {
        if let id = authRepo.session?.user.id {
            try await wordbookRepo.updateWord(wordId: wordId, userId: id, bookId: wordbook.bookId, original: original, translated: translated,
                                              priority: priority, missed: missed, synonyms: synonyms, antonyms: antonyms, examples: examples)
        } else {
            print("Session Expired")
        }
    }
    
    func removeWord(for wordbook: Wordbook, at index: Int) async throws {
        if let id = authRepo.session?.user.id {
            try await wordbookRepo.removeWord(userId: id, for: wordbook, at: index)
        } else {
            print("Session Expired")
        }
    }
}
