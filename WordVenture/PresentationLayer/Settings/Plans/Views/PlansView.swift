//
//  PlansView.swift
//  WordVenture
//
//  Created by Yu Takahashi on 5/31/23.
//

import SwiftUI

struct PlansView: View {
    
    @StateObject private var controller = PlansController()
    let unlimitedContents = ["unlimitedWordbooks", "unlimitedWords"]
    
    let selfNavigatable: Bool
    
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
                    
                    VStack(alignment: .leading) {
                        Text("unlimitedDescription")
                            .foregroundColor(Color(.secondaryLabel))
                            .padding(.top, 5)
                        
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("contents")
                            ForEach(unlimitedContents, id: \.self) { content in
                                Text(" • ") + Text(LocalizedStringKey(stringLiteral: content))
                            }
                        }
                    }
                    .padding()
                    
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
                    .padding([.horizontal, .top])
                    .onTapGesture {
                        controller.showManageSubscriptionSheet()
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 200)
                .frame(minWidth: 0, maxWidth: .infinity)
            }
            .animation(.spring(), value: controller.selectedPeriod)
            .ignoresSafeArea(edges: .bottom)
            
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
                .background(controller.isAvailable ? Color.blue : .gray)
                .cornerRadius(15)
                .shadow(color: (controller.isAvailable ? Color.blue : .gray).opacity(0.25), radius: 10, y: 4)
                .disabled(!controller.isAvailable)
                .animation(.spring(), value: controller.isAvailable)
            }
            .padding()
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
