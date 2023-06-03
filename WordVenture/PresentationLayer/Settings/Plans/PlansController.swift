//
//  PlansController.swift
//  WordVenture
//
//  Created by Yu Takahashi on 5/31/23.
//

import Foundation
import StoreKit

class PlansController: ObservableObject {
    
    private let iapUseCase = IAPUseCase()
    
    @Published var products = [Product]()
    @Published var selectedPlan: Plan = .free
    @Published var expandedPlan: Plan? = nil
    @Published var unlimitedPeriod: UnlimitedPeriod = .monthly
    @Published var isSubscriptionManagerShown = false
    @Published var isOfferCodeRedepmtionShown = false
    @Published var purchasedNonConsumables = Set<Product>()
    var transacitonListener: Task<Void, Error>?

    
    init() {
        requestProducts()
        
        transacitonListener = listenForTransactions()
        Task {
            await updateCurrentEntitlements()
        }
    }
    
    func showManageSubscriptionSheet() {
        isSubscriptionManagerShown = true
    }
    
    func showOfferCodeRedepmtionSheet() {
        isOfferCodeRedepmtionShown = true
    }
    
    func requestProducts() {
        Task { @MainActor in
            do {
                products = try await iapUseCase.fetchProducts()
            } catch {
                print(error)
            }
        }
    }
    
    func expand(for plan: Plan) {
        if expandedPlan == plan {
            expandedPlan = nil
        } else {
            expandedPlan = plan
        }
    }
    
    func getPrice(for plan: Plan) -> String {
        var product: Product? = nil
        
        if plan == .removeAds {
            product = products.filter( { $0.id == plan.id }).first
        } else if plan == .unlimited {
            product = products.filter( { $0.id == unlimitedPeriod.id }).first
        }
        
        return product?.displayPrice ?? "N/A"
    }
    
    func purchaseProduct() {
        Task { @MainActor in
            do {
                var product: Product? = nil
                
                if selectedPlan == .removeAds {
                    product = products.filter( { $0.id == selectedPlan.id }).first
                } else if selectedPlan == .unlimited {
                    product = products.filter( { $0.id == unlimitedPeriod.id }).first
                } else {
                    return
                }
                
                guard let product = product else {
                    return
                }
                
                let transaction = try await iapUseCase.purchaseProduct(for: product)
                print(transaction)
            } catch {
                print(error)
            }
        }
    }
    
    func restorePurchase() {
        Task { @MainActor in
            do {
                try await iapUseCase.restorePurchase()
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: - Transactions
    
    @MainActor
    private func handle(transactionVerification result: VerificationResult <Transaction> ) async {
        switch result {
        case let.verified(transaction):
            guard
                let product = self.products.first(where: {
                    $0.id == transaction.productID
                })
            else {
                return
            }
            self.purchasedNonConsumables.insert(product)
            await transaction.finish()
        default:
            return
        }
    }
    
    func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            for await result in Transaction.updates {
                await self.handle(transactionVerification: result)
            }
        }
    }
    
    private func updateCurrentEntitlements() async {
        for await result in Transaction.currentEntitlements {
            await self.handle(transactionVerification: result)
        }
    }
}
