//
//  LoadingController.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/25/23.
//

import Foundation

class LoadingController: ObservableObject {
    private var screenController = ScreenController.shared
    private let authService = AuthService()
    private let wordbookService = WordbookService()
    
    let launchAnimationPath = Bundle.main.path(forResource: "BookStack", ofType: "gif")!
    
    @MainActor
    func load() async {
        do {
            try await authService.isSignedIn()
            try await wordbookService.fetchWordbook()
            screenController.state = .main
        } catch {
            print(error)
            screenController.state = .auth
        }
    }
}
