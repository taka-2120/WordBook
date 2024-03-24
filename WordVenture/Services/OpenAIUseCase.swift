//
//  OpenAIUseCase.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/3/23.
//

import Foundation

class OpenAIUseCase {
    func fetchGeneratedText(for word: String, mode: PromptMode) async throws -> [String]? {
        return try await OpenAIRepositoryImpl.fetchGeneratedText(for: word, mode: mode)
    }
}
