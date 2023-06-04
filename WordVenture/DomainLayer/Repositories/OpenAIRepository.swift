//
//  OpenAIRepository.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/3/23.
//

import Foundation

protocol OpenAIRepository: AnyObject {
    func fetchGeneratedText(for word: String, mode: PromptMode) async throws -> [String]?
}
