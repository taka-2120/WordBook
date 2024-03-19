//
//  OpenAIUseCase.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/3/23.
//

import Foundation

class OpenAIUseCase {
    private let openAIRepository: OpenAIRepository
    
    init() {
        openAIRepository = OpenAIRepositoryImpl()
    }
    
    func fetchGeneratedText(for word: String, mode: PromptMode) async throws -> [String]? {
        return try await openAIRepository.fetchGeneratedText(for: word, mode: mode)
    }
}
