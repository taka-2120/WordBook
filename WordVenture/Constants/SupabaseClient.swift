//
//  SupabaseClient.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/24/23.
//

import Foundation
import Supabase

nonisolated(unsafe) let client = SupabaseClient(supabaseURL: URL(string: ENV().databaseUrl)!, supabaseKey: ENV().supabaseApiKey)
