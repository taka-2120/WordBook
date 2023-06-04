//
//  UnsplashAPI.swift
//  WordVenture
//
//  Created by Yu Takahashi on 5/25/23.
//

import Foundation

class UnsplashRepositoryImpl: UnsplashRepository {
    
    func fetchUnsplashImageUrls(for word: String) async throws -> [String] {
        return try await UnsplashDataSource.fetchUnsplashImageUrls(for: word)
    }
}
