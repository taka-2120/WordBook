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
    private let purchaseManager = PurchaseManager.shared
    
    let launchAnimationPath = Bundle.main.path(forResource: "BookStack", ofType: "gif")!
    
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    
    @MainActor
    func load() async {
        do {
            try await authService.isSignedIn()
            _ = try await wordbookService.fetchWordbook()
            await purchaseManager.updatePurchasedProducts()
            screenController.state = .main
        } catch {
            errorMessage = error.localizedDescription
            isErrorShown = true
            print(error)
            screenController.state = .auth
        }
    }
}
