//
//  UnsplashService.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/3/23.
//

import Foundation

actor UnsplashService<UnsplashRepo: UnsplashRepository> {
    nonisolated func fetchUnsplashImageUrls(for word: String) async throws -> [String] {
        return try await UnsplashRepo.fetchUnsplashImageUrls(for: word)
    }
}
