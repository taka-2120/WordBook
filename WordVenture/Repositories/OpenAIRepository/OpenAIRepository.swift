//
//  OpenAIRepository.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/3/23.
//

protocol OpenAIRepository: Sendable {
    static func fetchGeneratedText(for word: String, mode: PromptMode) async throws -> [String]?
}
