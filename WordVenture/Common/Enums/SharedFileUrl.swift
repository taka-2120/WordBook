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
    case privacyPolicy = "privacy_policy"
}

extension SharedFile {
    var localizedUrl: String {
        let currentLanguage = Locale.current.language.languageCode?.identifier ?? "en"
        if currentLanguage.contains("ja") {
            return sharedBaseUrl + self.rawValue + "_ja.md"
        }
        return sharedBaseUrl + self.rawValue + "_en.md"
    }
    
    func getMarkdown() async -> String {
        let url = URL(string: self.localizedUrl)
        guard let url = url else {
            print("Invailed URL: \(self.localizedUrl)")
            return "Not Found"
        }
        
        do {
            let data = try await URLSession.shared.data(from: url).0
            let mdString = String(data: data, encoding: .utf8)
            return mdString ?? "Contents cannot be encoded"
        } catch {
            print(error.localizedDescription)
            return "Error occured while loading"
        }
    }
}
