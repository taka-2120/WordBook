//
//  WelcomeController.swift
//  WordVenture
//
//  Created by Yu Takahashi on 3/27/24.
//

import Foundation

class WelcomeController: ObservableObject {
    @Published var authNavPaths = [AuthMethod]()
    @Published var isPrivacyPolicyShown = false
    @Published var isTermsANdConditionsShown = false
    
    func navigate(to path: AuthMethod) {
        authNavPaths = [path]
    }
    
    func showPrivacyPolicy() {
        isPrivacyPolicyShown = true
    }
    
    func showTermsAndConditions() {
        isTermsANdConditionsShown = true
    }
}
