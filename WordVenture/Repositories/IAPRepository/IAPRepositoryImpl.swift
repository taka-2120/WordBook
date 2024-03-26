//
//  IAPRepo.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/3/23.
//

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
        case let .success(.unverified(_, error)):
            // Successful purchase but transaction/receipt can't be verified
            // Could be a jailbroken phone
            print("Unverified purchase. Might be jailbroken. Error: \(error)")
            return nil
        case .pending:
            // Transaction waiting on SCA (Strong Customer Authentication) or
            // approval from Ask to Buy
            return nil
        case .userCancelled:
            print("User Cancelled!")
            return nil
        @unknown default:
            print("Failed to purchase the product!")
            return nil
        }
    }
    
    static func restorePurchase() async throws {
        try await AppStore.sync()
    }
    
    static func getPurchasedIds() async throws -> [String] {
        var productIds = [String]()
        
        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else {
                continue
            }
            if transaction.revocationDate == nil {
                productIds.append(transaction.productID)
            } else {
                productIds = productIds.filter { $0 != transaction.productID }
            }
        }
        
        return productIds
    }
}
