//
//  iSOtoDate.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/19/23.
//

import Foundation

extension String {
    func isoToDate() -> Date? {
        let formatter = ISO8601DateFormatter()
        let date = formatter.date(from: self)
        return date
    }
}
