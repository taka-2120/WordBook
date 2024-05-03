//
//  VentureLoading.swift
//  WordVenture
//
//  Created by Yu Takahashi on 3/29/24.
//

import Foundation

@MainActor
class LoadingManager: ObservableObject {
    static let shared = LoadingManager()
    private init() {}
    
    @Published var isLoading = false

    func loadingTask(action: @escaping () async -> Void) {
        Task { @MainActor in
            self.isLoading = true
            await action()
            self.isLoading = false
        }
    }
}

@MainActor
class LoadablePresenter: ObservableObject {
    @Published var isLoading = false
    
    func loadingTask(action: @escaping () async -> Void) {
        Task { @MainActor in
            self.isLoading = true
            await action()
            self.isLoading = false
        }
    }
}
