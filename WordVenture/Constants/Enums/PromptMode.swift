//
//  PromptMode.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/3/23.
//

import Foundation

enum PromptMode: String {
    case synonyms = "synonyms"
    case antonyms = "antonyms"
    case examples = "short example sentences using the word without number at the front of each sentence"
    case translate = "translate"
    
    var format: String {
        switch self {
        case .synonyms: return "xxx, xxx, xxx, xxx"
        case .antonyms: return "xxx, xxx, xxx, xxx"
        case .examples: return "xxx\nxxx\nxxx\nxxx"
        case .translate: return ""
        }
    }
}
