//
//  PlansController.swift
//  WordVenture
//
//  Created by Yu Takahashi on 5/31/23.
//

import Foundation
import StoreKit
import SwiftUI

@MainActor class PlansController: ObservableObject, Sendable {
    private let iapService = IAPServiceImpl()
    
    @Published var products = [Product]()
    @Published var currentPeriod: UnlimitedPeriod? = nil
    @Published var hasUnlimited = false
    @Published var selectedPeriod: UnlimitedPeriod = .monthly {
        willSet {
            refreshPurchaseState(for: newValue.id)
        }
    }
    @Published var isAvailable = false
    
    @Published var isSubscriptionManagerShown = false {
        willSet {
            if newValue == false {
                reflectPurchaseState()
            }
        }
    }
    @Published var isOfferCodeRedepmtionShown = false {
        willSet {
            if newValue == false {
                reflectPurchaseState()
            }
        }
    }
    @Published var isRefundSheetShown = false {
        willSet {
            if newValue == false {
                reflectPurchaseState()
            }
        }
    }

    
    init() {
        requestProducts()
        self.reflectPurchaseState()
        self.refreshPurchaseState(for: self.selectedPeriod.id)
        
        Task { @MainActor in
            self.hasUnlimited = await iapService.hasUnlimited()
        }
    }
    
    func reflectPurchaseState() {
        if hasUnlimited {
            Task { @MainActor in
                currentPeriod = await iapService.isPurchased(for: UnlimitedPeriod.monthly.id) ? .monthly : .annually
                selectedPeriod = currentPeriod!
            }
        } else {
            currentPeriod = nil
            selectedPeriod = .monthly
        }
    }
    
    func showManageSubscriptionSheet() {
        isSubscriptionManagerShown = true
    }
    
    func showOfferCodeRedepmtionSheet() {
        isOfferCodeRedepmtionShown = true
    }
    
    func getCurrentPlanName() -> String {
        if let currentPeriod = currentPeriod {
            return currentPeriod.periodName
        }
        return "free"
    }
    
    func getLocalizedPrice(for period: UnlimitedPeriod) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.currencySymbol = Locale.current.currencySymbol ?? ""
        formatter.internationalCurrencySymbol = Locale.current.currencySymbol ?? ""
        formatter.numberStyle = .currencyAccounting
        let localizedPrice = formatter.string(from: period.price as NSNumber) ?? ""
        
        return localizedPrice
    }
    
    func requestProducts() {
        Task { @MainActor in
            do {
                products = try await iapService.fetchProducts()
            } catch {
                print(error)
            }
        }
    }
    
    func selectPeriod(for period: UnlimitedPeriod) {
        selectedPeriod = period
    }
    
    func getPrice(for period: UnlimitedPeriod) -> String {
        var product: Product? = nil
        product = products.filter( { $0.id == period.id }).first
        
        return product?.displayPrice ?? "N/A"
    }
    
    private func refreshPurchaseState(for productId: String) {
        // Check if the period is available
        if currentPeriod == nil {
            // If user doesn't subscribe to any plan...
            isAvailable = true
            return
        }
        
        Task { @MainActor in
            let hasPurchased = await iapService.isPurchased(for: productId)
            isAvailable = !hasPurchased
        }
    }
    
    func purchaseProduct(dismissAction: @escaping () -> Void) {
        Task { @MainActor in
            do {
                var product: Product? = nil
                
                product = products.filter( { $0.id == selectedPeriod.id }).first
                
                guard let product = product else {
                    print("Products are not available")
                    return
                }
                
                let transaction = try await iapService.purchaseProduct(for: product)
                
                if transaction != nil {
                    reflectPurchaseState()
                    dismissAction()
                }
            } catch {
                print(error)
            }
        }
    }
    
    func restorePurchase() {
        Task { @MainActor in
            do {
                try await iapService.restorePurchase()
                reflectPurchaseState()
            } catch {
                print(error)
            }
        }
    }
}
