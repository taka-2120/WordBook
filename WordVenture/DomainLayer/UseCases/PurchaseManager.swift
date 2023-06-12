//
//  PurchaseManager.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/4/23.
//

import SwiftUI
import StoreKit

final class PurchaseManager {
    
    init() {
        listenTransaction()
    }
    
    deinit {
        cancelListeningTransaction()
    }
    
    private var purchasedProductIDs = Set<String>()
    private var updates: Task<Void, Never>? = nil
    
    // Product State
    var hasNoPlan: Bool {
        return !hasUnlimited
    }
    
    var hasUnlimited: Bool {
        let monthlyContains = purchasedProductIDs.contains(UnlimitedPeriod.monthly.id)
        let annuallyContains = purchasedProductIDs.contains(UnlimitedPeriod.annually.id)
        return monthlyContains || annuallyContains
    }
        
    private func handle(updatedTransaction verificationResult: VerificationResult<StoreKit.Transaction>) {
        guard case .verified(let transaction) = verificationResult else {
            // Ignore unverified transactions.
            print("Ignore unverified transactions")
            return
        }
        
        if let revocationDate = transaction.revocationDate {
            // Remove access to the product identified by transaction.productID.
            // Transaction.revocationReason provides details about
            // the revoked transaction.
            print("Transaction Revoked at \(revocationDate)")
            self.purchasedProductIDs.remove(transaction.productID)
        } else if let expirationDate = transaction.expirationDate, expirationDate < Date() {
            // Do nothing, this subscription is expired.
            print("Transaction Expired")
            self.purchasedProductIDs.remove(transaction.productID)
            return
        } else if transaction.isUpgraded {
            // Do nothing, there is an active transaction
            // for a higher level of service.
            print("Transaction Upgraded")
            return
        } else {
            // Provide access to the product identified by
            // transaction.productID.
            print("Transaction Verified")
            self.purchasedProductIDs.insert(transaction.productID)
        }
    }
    
    private func listenTransaction() {
        updates = observeTransactionUpdates()
        print("CALLED: listenTransaction")
    }
    
    private func cancelListeningTransaction() {
        updates?.cancel()
    }
    
    func fetchCurrentEntitlements(completion: @escaping () -> Void) {
        Task {
            for await verificationResult in Transaction.currentEntitlements {
                self.handle(updatedTransaction: verificationResult)
            }
            completion()
            print("fetchCurrentEntitlements: \(purchasedProductIDs)")
        }
    }
    
    func isPurchased(for productId: String) -> Bool {
        let contains = purchasedProductIDs.contains(productId)
        return contains
    }
    
    private func observeTransactionUpdates() -> Task<Void, Never> {
        Task(priority: .background) {
            for await verificationResult in Transaction.updates {
                self.handle(updatedTransaction: verificationResult)
                print("CALLED: observeTransactionUpdates")
                print("fetchCurrentEntitlements: \(purchasedProductIDs)")
            }
        }
    }
}
