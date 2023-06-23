//
//  WordbookApp.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/09/30.
//

import SwiftUI

@main
struct WordbookApp: App {
    @StateObject private var screenController = ScreenController.shared
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch screenController.state {
                case .auth: WelcomeView()
                case .main: WordbooksView()
                case .loading: LoadingView()
                }
            }
            .animation(.easeInOut, value: screenController.state)
        }
    }
}
