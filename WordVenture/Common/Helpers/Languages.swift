//
//  Languages.swift
//  WordVenture
//
//  Created by Yu Takahashi on 5/19/23.
//

import Foundation

func allLanguages() -> [String] {
    let languages = NSLocale.isoLanguageCodes
    return languages
}
