//
//  WordbookRepo.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import Foundation
import Supabase

class WordbookRepositoryImpl: WordbookRepository {
    
    func fetchWordbook(userId: UUID) async throws -> [Wordbook] {
        let response = try await WordbooksDataSource.fetchWordbook(userId: userId)
        
        var wordbooks = [Wordbook]()
        for wordbook in response {
            let words = try await fetchWords(userId: userId, bookId: wordbook.bookId)
            wordbooks.append(Wordbook(bookId: wordbook.bookId,
                                      userId: wordbook.userId,
                                      name: wordbook.name,
                                      color: wordbook.color,
                                      original: wordbook.original,
                                      translated: wordbook.translated,
                                      words: words,
                                      modifiedDate: wordbook.modifiedDate))
        }
        wordbooks.sort(by: {$0.name < $1.name})
        
        return wordbooks
    }
    
    func insertWordbook(userId: UUID, name: String, color: String, original: String, translated: String) async throws -> [Wordbook] {
        try await WordbooksDataSource.insertWordbook(userId: userId, name: name, color: color, original: original, translated: translated)
        
        return try await fetchWordbook(userId: userId)
    }
    
    func updateWordbook(bookId: UUID, userId: UUID, name: String, color: String, original: String?, translated: String?) async throws -> [Wordbook] {
        try await WordbooksDataSource.updateWordbook(bookId: bookId, userId: userId, name: name, color: color, original: original, translated: translated)
        
        return try await fetchWordbook(userId: userId)
    }
    
    func removeWordbook(userId: UUID, target bookId: UUID) async throws -> [Wordbook] {
        try await WordbooksDataSource.removeWordbook(userId: userId, target: bookId)
        
        return try await fetchWordbook(userId: userId)
    }
    
    private func fetchWords(userId: UUID, bookId: UUID) async throws -> [Word] {
        let response = try await WordbooksDataSource.fetchWords(userId: userId, bookId: bookId)
        
        var words = [Word]()
        for word in response {
            words.append(Word(userId: userId,
                              wordId: word.wordId,
                              bookId: word.bookId,
                              original: word.original,
                              translated: word.translated,
                              priority: word.priority,
                              missed: word.missed,
                              thumbnailUrl: word.thumbnailUrl,
                              imageUrls: word.imageUrls ?? [],
                              synonyms: word.synonyms,
                              antonyms: word.antonyms,
                              examples: word.examples,
                              imageSearchCount: word.imageSearchCount,
                              textGeneratedCount: word.textGeneratedCount))
        }
        
        return words
    }
    
    func insertWord(word: Word) async throws {
        try await WordbooksDataSource.insertWord(word: word)
    }
    
    func updateWord(word: Word) async throws {
        try await WordbooksDataSource.updateWord(word: word)
    }
    
    func removeWord(userId: UUID, target wordId: UUID) async throws {
        try await WordbooksDataSource.removeWord(target: wordId)
    }
}
