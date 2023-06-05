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
                    VStack {
                        Spacer()
                        Image(systemName: "exclamationmark.arrow.triangle.2.circlepath")
                            .symbolRenderingMode(.hierarchical)
                            .font(.largeTitle)
                        Text("You have any refundable purchase.")
                            .font(.title3)
                            .fontWeight(.bold)
                        Spacer()
                    }
                } else {
                    Form {
                        ForEach(controller.entitlements, id: \.id) { transaction in
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(Plan.allCases.filter({ $0.id == transaction.productID }).first?.name ?? UnlimitedPeriod.allCases.filter({ $0.id == transaction.productID }).first?.name ?? "")
                                    Text(transaction.purchaseDate.formatted())
                                        .foregroundColor(Color(.secondaryLabel))
                                        .font(.callout)
                                }
                                Spacer()
                                Button("Refund") {
                                    controller.startRefund(transactionID: transaction.id)
                                }
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
            }
            .navigationTitle("Refundable Purchases")
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
