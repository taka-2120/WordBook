//
//  PlansView.swift
//  WordVenture
//
//  Created by Yu Takahashi on 5/31/23.
//

import SwiftUI

struct PlansView: View {
    
    @Environment (\.dismiss) private var dismiss
    @StateObject private var controller = PlansController()
    
    private let selfNavigatable: Bool
    
    init(selfNavigatable: Bool = false) {
        self.selfNavigatable = selfNavigatable
    }
    
    var body: some View {
        if selfNavigatable {
            NavigationView {
                content
            }
        } else {
            content
        }
    }
    
    var content: some View {
        ZStack {
            ScrollView {
                VStack {
                    PlanItem(period: .monthly)
                    PlanItem(period: .annually)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("unlimitedDescription")
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color(.secondaryLabel))
                            .padding(.top, 5)
                        
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("contents")
                            ForEach(unlimitedContents, id: \.self) { content in
                                Text(" • ") + Text(LocalizedStringKey(stringLiteral: content))
                            }
                        }
                        
                        // Unlimited Plan Notes
                        Group {
                            Text("cancelUnlimited")
                                .foregroundColor(Color(.secondaryLabel))
                            + Text("tapHere")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            + Text("toCancelIt")
                                .foregroundColor(Color(.secondaryLabel))
                        }
                        .multilineTextAlignment(.leading)
                        .padding(.top)
                        .font(.callout)
                        .onTapGesture {
                            controller.showManageSubscriptionSheet()
                        }
                    }
                    .padding()
                }
                .padding(.top, 20)
                .padding(.bottom, 200)
                .frame(minWidth: 0, maxWidth: .infinity)
            }
            .animation(.spring(), value: controller.selectedPeriod)
            .ignoresSafeArea(edges: .bottom)
            
            VStack {
                Spacer()
                VStack(spacing: 15) {
                    Text("renewNote \(controller.getPrice(for: controller.selectedPeriod)) \(LocalizedStringKey(stringLiteral: controller.selectedPeriod.periodName).toString())")
                        .multilineTextAlignment(.center)
                        .font(.caption)
                        .foregroundStyle(Color(.secondaryLabel))
                    
                    Button {
                        controller.purchaseProduct(dismissAction: { })
                    } label: {
                        Text("select")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: 250)
                    }
                    .background(controller.isAvailable ? Color.blue : .gray)
                    .cornerRadius(15)
                    .shadow(color: (controller.isAvailable ? Color.blue : .gray).opacity(0.25), radius: 10, y: 4)
                    .disabled(!controller.isAvailable)
                    .animation(.spring(), value: controller.isAvailable)
                    
                    Button {
                        controller.showOfferCodeRedepmtionSheet()
                    } label: {
                        Text("redeemCode")
                            .font(.callout)
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding([.top, .horizontal])
                .padding(.bottom, 8)
                .background(.regularMaterial)
                .background(ignoresSafeAreaEdges: .bottom)
            }
        }
        .navigationTitle("plans")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button {
                        controller.restorePurchase()
                    } label: {
                        Label("restorePurchase", systemImage: "arrow.counterclockwise")
                    }
                    
                    Button {
                        controller.showManageSubscriptionSheet()
                    } label: {
                        Label("manageSubs", systemImage: "square.and.pencil")
                    }
                    
                    Button {
                        controller.showOfferCodeRedepmtionSheet()
                    } label: {
                        Label("redeemCode", systemImage: "ticket.fill")
                    }
                    
                    Divider()
                    
                    Button(role: .destructive) {
                        controller.isRefundSheetShown = true
                    } label: {
                        Label("requestRefunc", systemImage: "dollarsign.arrow.circlepath")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .imageScale(.large)
                }
            }
            
            if selfNavigatable {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
        .manageSubscriptionsSheet(isPresented: $controller.isSubscriptionManagerShown)
        .offerCodeRedemption(isPresented: $controller.isOfferCodeRedepmtionShown)
        .sheet(isPresented: $controller.isRefundSheetShown) {
            RefundView()
        }
        .environmentObject(controller)
    }
}

struct PlansView_Previews: PreviewProvider {
    static var previews: some View {
        PlansView()
    }
}
