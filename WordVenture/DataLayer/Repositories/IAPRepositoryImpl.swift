//
//  IAPRepo.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/3/23.
//

// Referenced: https://adapty.io/blog/in-app-purchase-tutorial-for-ios/
// Finished until Step 6

import StoreKit

class IAPRepositoryImpl: IAPRepository {
    
    func fetchProducts() async throws -> [Product] {
        return try await IAPDataSource.fetchProducts()
    }
    
    func purchaseProduct(for product: Product) async throws -> Transaction? {
        return try await IAPDataSource.purchaseProduct(for: product)
    }
    
    func restorePurchase() async throws {
        try await IAPDataSource.restorePurchase()
    }
    
}
