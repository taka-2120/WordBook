//
//  UnsplashUseCase.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/3/23.
//

import Foundation

class UnsplashUseCase {
    func fetchUnsplashImageUrls(for word: String) async throws -> [String] {
        return try await UnsplashRepositoryImpl.fetchUnsplashImageUrls(for: word)
    }
}
