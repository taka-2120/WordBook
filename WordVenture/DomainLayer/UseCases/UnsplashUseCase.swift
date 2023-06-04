//
//  UnsplashUseCase.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/3/23.
//

import Foundation

class UnsplashUseCase {
    private let unsplashRepository: UnsplashRepository
    
    init() {
        unsplashRepository = UnsplashRepositoryImpl()
    }
    
    func fetchUnsplashImageUrls(for word: String) async throws -> [String] {
        return try await unsplashRepository.fetchUnsplashImageUrls(for: word)
    }
}
