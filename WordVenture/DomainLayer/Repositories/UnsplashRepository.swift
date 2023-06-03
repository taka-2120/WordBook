//
//  UnsplashRepository.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/3/23.
//

import Foundation

protocol UnsplashRepository: AnyObject {
    func fetchUnsplashImageUrls(for word: String) async throws -> [String]
}
