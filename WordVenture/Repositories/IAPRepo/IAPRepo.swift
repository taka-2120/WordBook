//
//  IAPRepo.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/3/23.
//

import StoreKit

class IAPRepo: ObservableObject {
    
    private let productIDs = ["yutakahashi.WordVenture.Remove_Ads"]
    
    func fetchProducts() async throws -> [Product] {
        try await Product.products(for: productIDs)
    }
}
