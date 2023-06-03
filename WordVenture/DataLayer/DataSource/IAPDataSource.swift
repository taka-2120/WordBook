//
//  IAPDataSource.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/3/23.
//

import Foundation
import StoreKit

class IAPDataSource: NSObject {
    
    class func fetchProducts() async throws -> [Product] {
        return try await Product.products(for: productIds)
    }
    
}
