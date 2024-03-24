//
//  IAPUseCase.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/3/23.
//

import StoreKit

class IAPUseCase {
    func fetchProducts() async throws -> [Product] {
        return try await IAPRepositoryImpl.fetchProducts()
    }
    
    func purchaseProduct(for product: Product) async throws -> Transaction? {
        return try await IAPRepositoryImpl.purchaseProduct(for: product)
    }
    
    func restorePurchase() async throws {
        try await IAPRepositoryImpl.restorePurchase()
    }
}
