//
//  IAPDataSource.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/3/23.
//

import Foundation
import StoreKit

final class IAPDataSource: NSObject, Sendable {
    
    class func fetchProducts() async throws -> [Product] {
        let identifiers: [String] = [UnlimitedPeriod.monthly.id, UnlimitedPeriod.annually.id]
        return try await Product.products(for: identifiers)
    }
    
    class func purchaseProduct(for product: Product) async throws -> Transaction? {
        let result = try await product.purchase(options: [.simulatesAskToBuyInSandbox(true)])
        
        switch result {
        case .success(.verified(let transaction)):
            await transaction.finish()
            return transaction
        default: return nil
        }
    }
    
    class func restorePurchase() async throws {
        try await AppStore.sync()
    }
    
}
