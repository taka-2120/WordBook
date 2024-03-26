//
//  Regex.swift
//  WordBook
//
//  Created by Yu Takahashi on 5/18/23.
//

import Foundation

enum RegexType: String {
    case usernameRegex = "^.{1,15}$"
    case emailRegex = "[^@ \t\r\n]+@[^@ \t\r\n]+.[^@ \t\r\n]+"
    case passwordRegex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*_.-]).{8,}$"
}

extension RegexType {
    var notes: String {
        switch self {
        case .usernameRegex:
            "usernameRegexNotes"
        case .emailRegex:
            "emailRegexNotes"
        case .passwordRegex:
            "passwordRegexNotes"
        }
    }
}
