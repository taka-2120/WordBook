//
//  SharedFileUrl.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/4/23.
//

import Foundation

enum SharedFile: String {
    case releaseNotes = "release_notes"
    case upcoming = "upcoming"
}

extension SharedFile {
    var localizedUrl: String {
        let currentLanguage = Locale.current.language.languageCode?.identifier ?? "en"
        if currentLanguage.contains("ja") {
            return sharedBaseUrl + self.rawValue + "_ja.md"
        }
        return sharedBaseUrl + self.rawValue + "_en.md"
    }
    
    func getMarkdown() -> String {
        let url = URL(string: self.localizedUrl)!
        let data = try! Data(contentsOf: url)
        let mdString = String(data: data, encoding: .utf8)!
        return mdString
    }
}
