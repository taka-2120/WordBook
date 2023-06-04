//
//  PurchaseManager.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/4/23.
//

import SwiftUI
import StoreKit

class PurchaseManager {
    @Published private(set) var purchasedProductIDs = Set<String>()
    
    private var updates: Task<Void, Never>? = nil
    
    var hasAdsRemoved: Bool {
        return purchasedProductIDs.contains(Plan.removeAds.id)
    }
    
    var hasUnlimited: Bool {
        let monthlyContains = purchasedProductIDs.contains(UnlimitedPeriod.monthly.id)
        let annuallyContains = purchasedProductIDs.contains(UnlimitedPeriod.annually.id)
        return monthlyContains || annuallyContains
    }
    
    init() {
        updates = observeTransactionUpdates()
    }
    
    deinit {
        updates?.cancel()
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
    
    private func observeTransactionUpdates() -> Task<Void, Never> {
        Task(priority: .background) { [unowned self] in
            for await verificationResult in Transaction.updates {
                // Using verificationResult directly would be better
                // but this way works for this tutorial
                await self.updatePurchasedProducts()
            }
        }
    }
}
