//
//  PlansController.swift
//  WordVenture
//
//  Created by Yu Takahashi on 5/31/23.
//

import Foundation
import StoreKit

class PlansController: ObservableObject {
    
    private let purchaseManager = PurchaseManager.shared
    private let iapUseCase = IAPUseCase()
    
    @Published var currentPlan: Plan = .free
    @Published var products = [Product]()
    @Published var selectedPlan: Plan = .free
    @Published var expandedPlan: Plan? = nil
    @Published var unlimitedPeriod: UnlimitedPeriod = .monthly
    @Published var isSubscriptionManagerShown = false
    @Published var isOfferCodeRedepmtionShown = false
    @Published var isRefundSheetShown = false

    
    init() {
        requestProducts()
        purchaseManager.listenTransaction()
        reflectPurchaseState()
    }
    
    deinit {
        purchaseManager.cancelListeningTransaction()
    }
    
    func reflectPurchaseState() {
        if hasAdsRemoved() {
            selectedPlan = .removeAds
            currentPlan = .removeAds
        } else if hasUnlimited() {
            selectedPlan = .unlimited
            currentPlan = .unlimited
            unlimitedPeriod = purchaseManager.purchasedProductIDs.contains(UnlimitedPeriod.monthly.id) ? .monthly : .annually
        } else {
            selectedPlan = .free
        }
    }
    
    func hasAdsRemoved() -> Bool {
        return purchaseManager.hasAdsRemoved
    }
    
    func hasUnlimited() -> Bool {
        return purchaseManager.hasUnlimited
    }
    
    func isAvailable() -> Bool {
        if selectedPlan == .removeAds {
            let hasPurchased = purchaseManager.purchasedProductIDs.contains(selectedPlan.id)
            return !hasPurchased
        } else if selectedPlan == .unlimited {
            let hasPurchased = purchaseManager.purchasedProductIDs.contains(unlimitedPeriod.id)
            return !hasPurchased
        }
        
        if hasUnlimited() && selectedPlan == .free {
            return true
        }
        
        return false
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
                
                _ = try await iapUseCase.purchaseProduct(for: product)
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
}
