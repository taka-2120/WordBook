//
//  AssetUrl.swift
//  WordVenture
//
//  Created by Yu Takahashi on 3/26/24.
//

import Foundation

enum AssetUrl: String {
    case bookGif
}

extension AssetUrl {
    var url: String {
        switch self {
        case .bookGif:
            return Bundle.main.path(forResource: "BookStack", ofType: "gif") ?? ""
        }
    }
}
