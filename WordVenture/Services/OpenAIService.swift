//
//  OpenAIService.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/3/23.
//

actor OpenAIService<OpenAIRepo: OpenAIRepository> {
    nonisolated func fetchGeneratedText(for word: String, mode: PromptMode) async throws -> [String]? {
        return try await OpenAIRepo.fetchGeneratedText(for: word, mode: mode)
    }
}
