//
//  String+Regex.swift
//  WordBook
//
//  Created by Yu Takahashi on 5/18/23.
//

import Foundation

extension String {
    func isVailed(type: RegexType) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: type.rawValue) else {
            return false
        }
        return regex.firstMatch(in: self, range: NSRange(self.startIndex..., in: self)) != nil
    }
}
