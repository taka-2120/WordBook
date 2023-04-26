//
//  WordbookRepo.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import Foundation
import Supabase

class WordbookRepo: WordbookRepoInterface {
    
    static let shared = WordbookRepo()
    private init() {}
    
    var wordbooks = [Wordbook]()
    
    @MainActor
    func insertWordbook(userId: UUID, name: String, color: String) async throws {
        let wordbook = WordbookAPIModel(userId: userId, name: name, color: color, modifiedDate: Date().ISO8601Format())
        
        let _ = try await client.database
                    .from(wordbooksTable)
                    .insert(values: wordbook, returning: .none)
                    .execute()
        
        try await fetchWordbook(userId: userId)
    }
    
    @MainActor
    func insertWord(userId: UUID, bookId: UUID, original: String, translated: String, priority: Int,
                    missed: Int, synonyms: [String], antonyms: [String], examples: [String]) async throws {
        
        let word = WordAPIModel(userId: userId, bookId: bookId, original: original, translated: translated, priority: priority, missed: missed, synonyms: synonyms, antonyms: antonyms, examples: examples)
        
        let _ = try await client.database
                .from(wordsTable)
                .insert(values: word, returning: .representation)
                .execute()
        
        try await fetchWordbook(userId: userId)
    }
    
    @MainActor
    func fetchWordbook(userId: UUID) async throws {
        let query = client.database
                    .from(wordbooksTable)
                    .select()
                    .eq(column: "userId", value: userId)
        
        let response: [WordbookAPIModel] = try await query.execute().value
        
        print(response)
        
        wordbooks = try await composeWordbooks(for: response)
    }
    
    @MainActor
    private func composeWordbooks(for response: [WordbookAPIModel]) async throws -> [Wordbook] {
        var wordbooks = [Wordbook]()
        
        for wordbook in response {
            let words = try await fetchWords(bookId: wordbook.bookId)
            wordbooks.append(Wordbook(bookId: wordbook.bookId,
                                      userId: wordbook.userId,
                                      name: wordbook.name,
                                      color: wordbook.color,
                                      words: words,
                                      modifiedDate: wordbook.modifiedDate))
        }
        
        return wordbooks
    }
    
    @MainActor
    private func fetchWords(bookId: UUID) async throws -> [Word] {
        let query = client.database
                    .from(wordsTable)
                    .select()
                    .eq(column: "bookId", value: bookId)
        
        let response: [WordAPIModel] = try await query.execute().value
        
        var words = [Word]()
        for word in response {
            words.append(Word(bookId: word.bookId, original: word.original, translated: word.translated, priority: word.priority, missed: word.missed, synonyms: word.synonyms, antonyms: word.antonyms, examples: word.examples))
        }
        
        return words
    }
    
}
