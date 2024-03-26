//
//  DateEx.swift
//  WordBook
//
//  Created by Yu Takahashi on 2022/07/03.
//

import Foundation

extension Date {
    func formatDateToString(showDate: Bool, showTime: Bool) -> String {
        let dateFormatter = DateFormatter()
        
        if showDate == true {
            dateFormatter.dateStyle = .medium
        }
        if showTime == true {
            dateFormatter.timeStyle = .short
        }
        
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: Locale.current.language.languageCode?.identifier ?? "en-US")
        
        return dateFormatter.string(from: self)
    }
}
