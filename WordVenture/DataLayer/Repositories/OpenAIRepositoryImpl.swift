//
//  ChatGPTAPI.swift
//  WordBook
//
//  Created by Yu Takahashi on 3/31/23.
//

import Foundation

class OpenAIRepositoryImpl: OpenAIRepository {
    
    func fetchGeneratedText(for word: String, mode: PromptMode) async throws -> [String]? {
        return try await OpenAIDataSource.fetchGeneratedText(for: word, mode: mode)
    }

}
