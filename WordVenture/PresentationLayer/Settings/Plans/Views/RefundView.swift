//
//  RefundView.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/4/23.
//

import SwiftUI

struct RefundView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var controller = RefundController()
    
    var body: some View {
        NavigationView {
            Group {
                if controller.entitlements.isEmpty {
                    VStack(spacing: 15) {
                        Spacer()
                        Image(systemName: "exclamationmark.arrow.triangle.2.circlepath")
                            .symbolRenderingMode(.hierarchical)
                            .font(.system(size: 64))
                        Text("noRefundablePurchases")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                    }
                } else {
                    Form {
                        ForEach(controller.entitlements, id: \.id) { transaction in
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(UnlimitedPeriod.allCases.filter({ $0.id == transaction.productID }).first?.periodName ?? "")
                                    Text(transaction.purchaseDate.formatted())
                                        .foregroundColor(Color(.secondaryLabel))
                                        .font(.callout)
                                }
                                Spacer()
                                Button("refund") {
                                    controller.startRefund(transactionID: transaction.id)
                                }
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
            }
            .navigationTitle("refundablePurchases")
            .navigationBarTitleDisplayMode(.inline)
            .refundRequestSheet(for: controller.selectedTransactionID ?? 0,
                                isPresented: $controller.isRefundRequestShown) { result in
                controller.handleRefund(result: result, dismiss)
            }
        }
    }
}

struct RefundView_Previews: PreviewProvider {
    static var previews: some View {
        RefundView()
    }
}
