//
//  IAPRepo.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/3/23.
//

// Referenced: https://adapty.io/blog/in-app-purchase-tutorial-for-ios/
// Finished until Step 6

import StoreKit

final class IAPRepositoryImpl: IAPRepository {
    static func fetchProducts() async throws -> [Product] {
        let identifiers: [String] = [UnlimitedPeriod.monthly.id, UnlimitedPeriod.annually.id]
        return try await Product.products(for: identifiers)
    }
    
    static func purchaseProduct(for product: Product) async throws -> Transaction? {
        let result = try await product.purchase(options: [.simulatesAskToBuyInSandbox(true)])
        
        switch result {
        case .success(.verified(let transaction)):
            await transaction.finish()
            return transaction
        default: return nil
        }
    }
    
    static func restorePurchase() async throws {
        try await AppStore.sync()
    }
}
