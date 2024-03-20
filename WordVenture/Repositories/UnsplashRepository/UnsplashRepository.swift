//
//  UnsplashRepository.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/3/23.
//

protocol UnsplashRepository: Sendable {
    static func fetchUnsplashImageUrls(for word: String) async throws -> [String]
}
