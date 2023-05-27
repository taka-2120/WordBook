//
//  Enums.swift
//  WordBook
//
//  Created by Yu Takahashi on 5/2/23.
//

import SwiftUI

enum CustomError: Error {
    case empty
    case longUsername
    case invaildEmailFormat
    case weakPassword
    case newPasswordNotMatched
    case unexpectedError
    case unhandled(msg: String)
}

extension CustomError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .empty: return String(localized: .init("emptyError"))
        case .longUsername: return String(localized: .init("longUsername"))
        case .invaildEmailFormat: return String(localized: .init("invaildEmailFormat"))
        case .weakPassword: return String(localized: .init("weakPassword"))
        case .newPasswordNotMatched: return String(localized: .init("newPasswordNotMatched"))
        case .unexpectedError: return String(localized: .init("unexpectedError"))
        case .unhandled: return "UNHANDLED"
        }
    }
}
