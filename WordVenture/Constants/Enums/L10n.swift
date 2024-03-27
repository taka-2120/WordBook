//
//  L10n.swift
//  WordVenture
//
//  Created by Yu Takahashi on 3/26/24.
//

import SwiftUI

enum L10n: LocalizedStringKey {
    case error = "error"
    case ok = "OK"
    
    // MARK: - Welcome View
    case apiIntro = "apiIntro"
    case cardIntro = "cardIntro"
    case signUp = "signUp"
    case signIn = "signIn"
    case usingAppNotes = "usingAppNotes"
    case privacyPolicy = "privacyPolicy"
    case termsAndConditions = "termsAndConditions"
    
    // MARK: - Sign In
    case welcomeBack = "welcomeBack"
    case email = "email"
    case password = "password"
    
    // MARK: - Forget Password
    case resetNote = "resetNote"
    case resetEmailNote = "resetEmailNote"
    case sendEmail = "sendEmail"
    case forgetPassword = "forgetPassword"
    
    // MARK: - Doc Prompt
    case agree = "agree"
    case disagree = "disagree"
}
