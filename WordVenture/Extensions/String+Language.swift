//
//  String+Language.swift
//  WordVenture
//
//  Created by Yu Takahashi on 5/19/23.
//

import Foundation

extension String {
    func guessLanguage() -> String? {
        let length = self.utf16.count
        let languageCode = CFStringTokenizerCopyBestStringLanguage(self as CFString, CFRange(location: 0, length: length)) as String? ?? ""
        
        let locale = Locale.init(identifier: languageCode)
        return locale.localizedString(forLanguageCode: languageCode)
    }
}
