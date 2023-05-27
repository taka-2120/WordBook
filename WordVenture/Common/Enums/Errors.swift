//
//  Enums.swift
//  WordBook
//
//  Created by Yu Takahashi on 5/2/23.
//

import Foundation

enum ErrorMessage: String {
    case empty = "emptyError"
    case longUsername = "longUsername"
    case invaildEmailFormat = "invaildEmailFormat"
    case weakPassword = "weakPassword"
    case newPasswordNotMatched = "newPasswordNotMatched"
    case unexpectedError = "unexpectedError"
}

enum UnhandledError: Error {
    case message(msg: String)
}
