//
//  UnsplashError.swift
//  WordVenture
//
//  Created by Yu Takahashi on 3/20/24.
//

import Foundation

enum UnsplashError: Error {
    case invalidUrl
}

extension UnsplashError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidUrl: "Invalid request URL"
        }
    }
}
