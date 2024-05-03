//
//  IAPService.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/3/23.
//

import StoreKit

actor IAPService<IAPRepo: IAPRepository> {
    nonisolated func fetchProducts() async throws -> [Product] {
        return try await IAPRepo.fetchProducts()
    }
    
    nonisolated func purchaseProduct(for product: Product) async throws -> Transaction? {
        return try await IAPRepo.purchaseProduct(for: product)
    }
    
    func restorePurchase() async throws {
        try await IAPRepo.restorePurchase()
    }
    
    nonisolated func getPurchasedIds() async throws -> [String] {
        try await IAPRepo.getPurchasedIds()
    }
    
    nonisolated func isPurchased(for productId: String) async -> Bool {
        do {
            return try await IAPRepo.getPurchasedIds().contains(where: { $0 == productId })
        } catch {
            print("failed to retrieve purchase status")
            return false
        }
    }
    
    nonisolated func hasUnlimited() async -> Bool {
        do {
            return !(try await IAPRepo.getPurchasedIds().isEmpty)
        } catch {
            print("failed to retrieve purchase status")
            return false
        }
    }
}
