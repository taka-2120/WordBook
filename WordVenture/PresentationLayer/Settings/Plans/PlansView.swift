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
                
                ScrollView {
                    PlanItem(plan: .free)
                        .padding(.top)
                    PlanItem(plan: .removeAds, product: controller.products.filter({ $0.id == Plan.removeAds.id }).first)
                    PlanItem(plan: .unlimited)
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
                .background(.blue)
                .cornerRadius(15)
                .shadow(color: .blue.opacity(0.25), radius: 10, y: 4)

            }
            .padding()
        }
        .manageSubscriptionsSheet(isPresented: $controller.isSubscriptionManagerShown)
        .offerCodeRedemption(isPresented: $controller.isOfferCodeRedepmtionShown)
        .navigationBarTitleDisplayMode(.inline)
        .environmentObject(controller)
    }
}

struct PlansView_Previews: PreviewProvider {
    static var previews: some View {
        PlansView()
    }
}
