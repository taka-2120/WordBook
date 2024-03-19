//
//  RefundController.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/4/23.
//

import SwiftUI
import StoreKit

@MainActor class RefundController: ObservableObject, Sendable {
    
    @Published var entitlements: [StoreKit.Transaction] = []
    
    @Published var selectedTransactionID: UInt64?
    @Published var isRefundRequestShown: Bool = false
    
    init() {
        Task {
            await fetchEntitlements()
        }
    }
    
    private func fetchEntitlements() async {
        for await result in Transaction.currentEntitlements {
            if case .verified(let transaction) = result {
                print(transaction)
                if transaction.revocationDate == nil {
                    entitlements.append(transaction)
                }
            }
        }
    }
    
    func startRefund(transactionID: UInt64) {
        selectedTransactionID = transactionID
        isRefundRequestShown = true
    }
    
    func handleRefund(result: Result<StoreKit.Transaction.RefundRequestStatus, StoreKit.Transaction.RefundRequestError>, _ dismiss: DismissAction) {
        switch result {
        case .success(.success):
            dismiss()
        default:
            return
        }
    }
}
