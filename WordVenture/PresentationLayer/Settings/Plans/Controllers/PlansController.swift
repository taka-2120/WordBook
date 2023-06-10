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
    
    private let purchaseManager = PurchaseManager.shared
    private let iapUseCase = IAPUseCase()
    
    @Published var products = [Product]()
    @Published var currentPeriod: UnlimitedPeriod? = nil
    @Published var selectedPeriod: UnlimitedPeriod = .monthly
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
        purchaseManager.listenTransaction()
        reflectPurchaseState()
    }
    
    deinit {
        purchaseManager.cancelListeningTransaction()
    }
    
    func reflectPurchaseState() {
        if hasUnlimited() {
            currentPeriod = purchaseManager.purchasedProductIDs.contains(UnlimitedPeriod.monthly.id) ? .monthly : .annually
            selectedPeriod = currentPeriod!
        } else {
            currentPeriod = nil
            selectedPeriod = .monthly
        }
    }
    
    func hasUnlimited() -> Bool {
        return purchaseManager.hasUnlimited
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
        Task {
            do {
                products = try await iapUseCase.fetchProducts()
                await purchaseManager.updatePurchasedProducts()
            } catch {
                print(error)
            }
        }
    }
    
    func selectPeriod(for period: UnlimitedPeriod) {
        selectedPeriod = period
        
        // Check if the period is available
        guard let currentPeriod = currentPeriod else {
            // If user doesn't subscribe to any plan...
            isAvailable = true
            return
        }
        
        let hasPurchased = purchaseManager.purchasedProductIDs.contains(period.id)
        isAvailable = !hasPurchased
    }
    
    func getPrice(for period: UnlimitedPeriod) -> String {
        var product: Product? = nil
        product = products.filter( { $0.id == period.id }).first
        
        return product?.displayPrice ?? "N/A"
    }
    
    func purchaseProduct() {
        Task {
            do {
                var product: Product? = nil
                
                product = products.filter( { $0.id == selectedPeriod.id }).first
                
                guard let product = product else {
                    return
                }
                
                _ = try await iapUseCase.purchaseProduct(for: product)
                await purchaseManager.updatePurchasedProducts()
                reflectPurchaseState()
            } catch {
                print(error)
            }
        }
    }
    
    func restorePurchase() {
        Task {
            do {
                try await iapUseCase.restorePurchase()
                await purchaseManager.updatePurchasedProducts()
                reflectPurchaseState()
            } catch {
                print(error)
            }
        }
    }
}
