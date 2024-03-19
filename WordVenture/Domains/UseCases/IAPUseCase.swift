//
//  IAPUseCase.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/3/23.
//

import Foundation
import StoreKit

class IAPUseCase {
    private let iapRepository: IAPRepository
    
    init() {
        iapRepository = IAPRepositoryImpl()
    }
    
    func fetchProducts() async throws -> [Product] {
        return try await iapRepository.fetchProducts()
    }
    
    func purchaseProduct(for product: Product) async throws -> Transaction? {
        return try await iapRepository.purchaseProduct(for: product)
    }
    
    func restorePurchase() async throws {
        try await iapRepository.restorePurchase()
    }
}
