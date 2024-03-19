//
//  IAPRepo.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/3/23.
//

import Foundation
import StoreKit

protocol IAPRepository: AnyObject {
    func fetchProducts() async throws -> [Product]
    func purchaseProduct(for product: Product) async throws -> Transaction?
    func restorePurchase() async throws
}
