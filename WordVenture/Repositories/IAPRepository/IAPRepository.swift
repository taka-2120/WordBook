//
//  IAPRepo.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/3/23.
//

import StoreKit

protocol IAPRepository: Sendable {
    static func fetchProducts() async throws -> [Product]
    static func purchaseProduct(for product: Product) async throws -> Transaction?
    static func restorePurchase() async throws
}
