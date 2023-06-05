//
//  PlansView.swift
//  WordVenture
//
//  Created by Yu Takahashi on 5/31/23.
//

import SwiftUI

struct PlansView: View {
    
    @StateObject private var controller = PlansController()
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text("plans")
                        .font(.title)
                        .bold()
                    Spacer()
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
                .padding(.bottom, 10)
                .padding(.horizontal)
                
//                TODO: Show current plan
                Group {
                    Text("Your current plan is: ") +
                    Text(controller.currentPlan.name)
                        .fontWeight(.semibold)
                }
                .font(.title3)
                .padding(.horizontal)
                
                ScrollView {
                    PlanItem(plan: .free, disabled: controller.hasAdsRemoved() || controller.hasUnlimited(), current: !(controller.hasAdsRemoved() || controller.hasUnlimited()))
                        .padding(.top)
                    PlanItem(plan: .removeAds, disabled: controller.hasUnlimited(), current: controller.hasAdsRemoved(), product: controller.products.filter({ $0.id == Plan.removeAds.id }).first)
                    PlanItem(plan: .unlimited, current: controller.hasUnlimited())
                    
                    if controller.hasUnlimited() {
                        Group {
                            Text("If you want to cancel Unlimited subscription, please ")
                                .foregroundColor(Color(.secondaryLabel))
                            + Text("tap here")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            + Text(" to cancel it.")
                                .foregroundColor(Color(.secondaryLabel))
                        }
                        .padding([.horizontal, .top])
                        .onTapGesture {
                            controller.showManageSubscriptionSheet()
                        }
                    }
                }
                .animation(.spring(), value: controller.expandedPlan)
                .ignoresSafeArea(edges: .bottom)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            
            VStack {
                Spacer()
                Button {
                    controller.purchaseProduct()
                } label: {
                    Text("select")
                        .foregroundColor(.white)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: 250)
                }
                .background(controller.isAvailable() ? Color.blue : .gray)
                .cornerRadius(15)
                .shadow(color: (controller.isAvailable() ? Color.blue : .gray).opacity(0.25), radius: 10, y: 4)
                .disabled(!controller.isAvailable())

            }
            .padding()
        }
        .manageSubscriptionsSheet(isPresented: $controller.isSubscriptionManagerShown)
        .offerCodeRedemption(isPresented: $controller.isOfferCodeRedepmtionShown)
        .sheet(isPresented: $controller.isRefundSheetShown) {
            RefundView()
        }
        .navigationBarTitleDisplayMode(.inline)
        .environmentObject(controller)
    }
}

struct PlansView_Previews: PreviewProvider {
    static var previews: some View {
        PlansView()
    }
}
