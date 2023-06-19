//
//  LoadingController.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/25/23.
//

import Foundation

@MainActor class LoadingController: ObservableObject, Sendable {
    private var screenController = ScreenController.shared
    private let authService = AuthService()
    private let wordbookService = WordbookService()
    private let purchaseManager = PurchaseManager.shared
    
    let launchAnimationPath = Bundle.main.path(forResource: "BookStack", ofType: "gif")!
    
    @Published var isPrivacyPolicyUpdated = false
    @Published var isTermsAndConditionsUpdated = false
    @Published var isLoadingFinished = false
    
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    
    func load() async {
        await checkFileDates()
        
        if isPrivacyPolicyUpdated || isTermsAndConditionsUpdated {
            return
        }
        
        await fetchData()
    }
    
    func fetchData() async {
        do {
            try await authService.isSignedIn()
            _ = try await wordbookService.fetchWordbook()
            screenController.state = .main
        } catch {
            errorMessage = error.localizedDescription
            isErrorShown = true
            print(error)
            screenController.state = .auth
        }
    }
    
    func disagree(for kind: DocKind) {
        isPrivacyPolicyUpdated = false
        isTermsAndConditionsUpdated = false
        signOut()
    }
    
    private func signOut() {
        Task {
            do {
                try await authService.signOut()
            } catch {
                print(error)
                errorMessage = error.localizedDescription
                isErrorShown = true
            }
            screenController.state = .auth
        }
    }
    
    func agree(for kind: DocKind) {
        switch kind {
        case .privacyPolicy:
            isPrivacyPolicyUpdated = false
            break
        case .termsAndConditions:
            isTermsAndConditionsUpdated = false
            break
        }
        
        if !isPrivacyPolicyUpdated && !isTermsAndConditionsUpdated {
            Task {
                await fetchData()
            }
        }
    }
    
    private func checkFileDates() async {
        let datesJson = await fetchSharedFileDates()
        
        let privacyPolicyDateStored = UserDefaults.standard.object(forKey: "privacyPolicyUpdatedDate") as? Date ?? Date()
        let termsAndConditionsDateStored = UserDefaults.standard.object(forKey: "termsAndConditionsUpdatedDate") as? Date ?? Date()
        
        let privacyPolicyDate = datesJson["privacy_policy"]?.isoToDate() ?? Date()
        let termsAndConditionsDate = datesJson["terms_and_conditions"]?.isoToDate() ?? Date()
        
        isPrivacyPolicyUpdated = privacyPolicyDateStored < privacyPolicyDate
        isTermsAndConditionsUpdated = termsAndConditionsDateStored < termsAndConditionsDate
    }
    
    private nonisolated func fetchSharedFileDates() async -> [String: String] {
        let datesUrl = sharedBaseUrl + "dates.json"
        let url = URL(string: datesUrl)
        
        guard let url = url else {
            print("Invailed URL: \(datesUrl)")
            return [:]
        }
        
        do {
            let data = try await URLSession(configuration: .ephemeral).data(from: url).0
            let datesJson = try JSONDecoder().decode([String: String].self, from: data)
            return datesJson
        } catch {
            print(error.localizedDescription)
            return [:]
        }
    }
}
