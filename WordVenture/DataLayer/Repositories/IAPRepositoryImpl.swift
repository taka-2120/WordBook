//
//  IAPRepo.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/3/23.
//

import StoreKit

class IAPRepositoryImpl: IAPRepository {
    
    func fetchProducts() async throws -> [Product] {
        return try await IAPDataSource.fetchProducts()
    }
    
}
