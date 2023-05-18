//
//  Enums.swift
//  WordBook
//
//  Created by Yu Takahashi on 5/2/23.
//

import Foundation

enum ErrorMessage: String {
    case empty = "Please fill out all entries."
    case longUsername = "This username is too long. Please enter it within 15 characters."
    case invaildEmailFormat = "This email address format is invaild."
    case weakPassword = "This password is too weak."
    case newPasswordNotMatched = "The new password and re-entered new password are not matched."
    case unexpectedError = "Unexpected error occured."
}
