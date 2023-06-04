//
//  ScreenService.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/25/23.
//

import Foundation

final class ScreenController: ObservableObject {
    static let shared = ScreenController()
    private init() {}
    
    @Published var state: States = .loading
}

enum States {
    case loading, auth, main
}
