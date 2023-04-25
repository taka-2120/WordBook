//
//  ProcessInfoKey.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import Foundation

extension ProcessInfo {
    static let openaiApiKey =  ProcessInfo.processInfo.environment["openaiApiKey"] ?? ""
    static let supabaseApiKey =  ProcessInfo.processInfo.environment["supabaseApiKey"] ?? ""
    static let databaseUrl =  ProcessInfo.processInfo.environment["databaseUrl"] ?? ""
}
