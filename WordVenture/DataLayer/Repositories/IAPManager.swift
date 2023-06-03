//
//  IAPManager.swift
//  WordVenture
//
//  Created by Yu Takahashi on 5/31/23.
//


import StoreKit

class IAPManager: ObservableObject {
    
    private var productIDs = ["yutakahashi.WordVenture.Remove_Ads"]
    
    @Published var products = [Product]()
    
    init() {
        Task {
            await requestProducts()
        }
    }
    
    @MainActor
    func requestProducts() async {
        do {
            products = try await Product.products(for: productIDs)
        } catch {
            print(error)
        }
    }
}
