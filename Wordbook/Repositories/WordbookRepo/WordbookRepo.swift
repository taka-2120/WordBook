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
    func fetchWordbook(userId: UUID) async throws {
        let query = client.database
                    .from(wordbooksTable)
                    .select()
                    .eq(column: "userId", value: userId)
        
        let response: [WordbookAPIModel] = try await query.execute().value
        
        print(response)
        
        wordbooks = try await composeWordbooks(userId: userId, for: response)
    }
    
    @MainActor
    func insertWordbook(userId: UUID, name: String, color: String) async throws {
        let wordbook = WordbookAPIModel(bookId: UUID(), userId: userId, name: name, color: color, modifiedDate: Date().ISO8601Format())
        
        let _ = try await client.database
                    .from(wordbooksTable)
                    .insert(values: wordbook, returning: .none)
                    .execute()
        
        try await fetchWordbook(userId: userId)
    }
    
    @MainActor
    func updateWordbook(bookId: UUID, userId: UUID, name: String, color: String) async throws {
        
        let wordbook = WordbookAPIModel(bookId: bookId, userId: userId, name: name, color: color, modifiedDate: Date().ISO8601Format())
        
        print(wordbook)
        
        let _ = try await client.database
                .from(wordbooksTable)
                .update(values: wordbook)
                .eq(column: "bookId", value: bookId)
                .execute()
        
        try await fetchWordbook(userId: userId)
    }
    
    @MainActor
    func removeWordbook(userId: UUID, at index: Int) async throws {
        
        let bookId = wordbooks[index].bookId
        
        let _ = try await client.database
                .from(wordbooksTable)
                .delete()
                .eq(column: "bookId", value: bookId)
                .execute()
        
        try await fetchWordbook(userId: userId)
    }
    
    @MainActor
    private func fetchWords(userId: UUID, bookId: UUID) async throws -> [Word] {
        let query = client.database
                    .from(wordsTable)
                    .select()
                    .eq(column: "bookId", value: bookId)
        
        let response: [WordAPIModel] = try await query.execute().value
        
        var words = [Word]()
        for word in response {
            words.append(Word(userId: userId, wordId: word.wordId, bookId: word.bookId, original: word.original, translated: word.translated, priority: word.priority, missed: word.missed, synonyms: word.synonyms, antonyms: word.antonyms, examples: word.examples))
        }
        
        return words
    }
    
    @MainActor
    func insertWord(userId: UUID, bookId: UUID, original: String, translated: String, priority: Int,
                    missed: Int, synonyms: [String], antonyms: [String], examples: [String]) async throws {
        
        let word = WordAPIModel(wordId: UUID(), userId: userId, bookId: bookId, original: original, translated: translated, priority: priority, missed: missed, synonyms: synonyms, antonyms: antonyms, examples: examples)
        
        let _ = try await client.database
                .from(wordsTable)
                .insert(values: word, returning: .representation)
                .execute()
        
        try await fetchWordbook(userId: userId)
    }
    
    @MainActor
    func updateWord(wordId: UUID, userId: UUID, bookId: UUID, original: String, translated: String, priority: Int,
                    missed: Int, synonyms: [String], antonyms: [String], examples: [String]) async throws {
        
        let word = WordAPIModel(wordId: wordId, userId: userId, bookId: bookId, original: original, translated: translated, priority: priority, missed: missed, synonyms: synonyms, antonyms: antonyms, examples: examples)
        
        let _ = try await client.database
                .from(wordsTable)
                .update(values: word)
                .eq(column: "wordId", value: wordId)
                .execute()
        
        try await fetchWordbook(userId: userId)
    }
    
    @MainActor
    func removeWord(userId: UUID, for wordbook: Wordbook, at index: Int) async throws {
        
        let wordId = wordbook.words[index].wordId
        
        let _ = try await client.database
                .from(wordsTable)
                .delete()
                .eq(column: "wordId", value: wordId)
                .execute()
        
        try await fetchWordbook(userId: userId)
    }
    
    @MainActor
    private func composeWordbooks(userId: UUID, for response: [WordbookAPIModel]) async throws -> [Wordbook] {
        var wordbooks = [Wordbook]()
        
        for wordbook in response {
            let words = try await fetchWords(userId: userId, bookId: wordbook.bookId)
            wordbooks.append(Wordbook(bookId: wordbook.bookId,
                                      userId: wordbook.userId,
                                      name: wordbook.name,
                                      color: wordbook.color,
                                      words: words,
                                      modifiedDate: wordbook.modifiedDate))
        }
        
        wordbooks.sort(by: {$0.name < $1.name})
        
        return wordbooks
    }
    
}
