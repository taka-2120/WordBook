//
//  DocKind.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/19/23.
//

import SwiftUI

enum DocKind {
    case privacyPolicy, termsAndConditions
}

extension DocKind {
    var key: LocalizedStringKey {
        switch self {
        case .privacyPolicy:
            return "privacyPolicy"
        case .termsAndConditions:
            return "termsAndConditions"
        }
    }
}
