//
//  Regex.swift
//  WordBook
//
//  Created by Yu Takahashi on 5/18/23.
//

import Foundation

let usernameRegex = "^[A-Za-z0-9_ -]{1,15}$"
let emailRegex = "[^@ \t\r\n]+@[^@ \t\r\n]+.[^@ \t\r\n]+"
let passwordRegex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@.$ %^&*-]).{8,}$"

enum RegexType: String {
    case usernameRegex = "^[A-Za-z0-9_ -]{1,15}$"
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
