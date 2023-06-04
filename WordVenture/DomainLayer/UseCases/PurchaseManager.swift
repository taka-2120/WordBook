//
//  PurchaseManager.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/4/23.
//

import SwiftUI
import StoreKit

class PurchaseManager {
    static let shared = PurchaseManager()
    private init () { }
    
    private(set) var purchasedProductIDs = Set<String>()
    private var updates: Task<Void, Never>? = nil
    
    // Product State
    var hasNoPlan: Bool {
        return !hasUnlimited && !hasAdsRemoved
    }
    
    var hasAdsRemoved: Bool {
        return purchasedProductIDs.contains(Plan.removeAds.id)
    }
    
    var hasUnlimited: Bool {
        let monthlyContains = purchasedProductIDs.contains(UnlimitedPeriod.monthly.id)
        let annuallyContains = purchasedProductIDs.contains(UnlimitedPeriod.annually.id)
        return monthlyContains || annuallyContains
    }
    
    
    func updatePurchasedProducts() async {
        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else {
                continue
            }
            
            if transaction.revocationDate == nil {
                self.purchasedProductIDs.insert(transaction.productID)
            } else {
                self.purchasedProductIDs.remove(transaction.productID)
            }
        }
    }
    
    func listenTransaction() {
        updates = observeTransactionUpdates()
    }
    
    func cancelListeningTransaction() {
        updates?.cancel()
    }
    
    private func observeTransactionUpdates() -> Task<Void, Never> {
        Task(priority: .background) { [unowned self] in
            for await _ in Transaction.updates {
                // Using verificationResult directly would be better
                // but this way works for this tutorial
                await self.updatePurchasedProducts()
            }
        }
    }
}
