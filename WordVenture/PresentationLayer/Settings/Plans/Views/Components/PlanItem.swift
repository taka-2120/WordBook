//
//  PlanItem.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/3/23.
//

import SwiftUI
import StoreKit

struct PlanItem: View {
    @EnvironmentObject private var controller: PlansController
    
    let plan: Plan
    let product: Product?
    let disabled: Bool
    let current: Bool
    
    init(plan: Plan, disabled: Bool = false, current: Bool = false, product: Product? = nil) {
        self.plan = plan
        self.disabled = disabled
        self.current = current
        self.product = product
    }
    
    var body: some View {
        let isSelected = controller.selectedPlan == plan
        
        VStack(spacing: 0) {
            HStack {
                Button {
                    controller.selectedPlan = plan
                } label: {
                    Image(systemName: current ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(current ? .green : .gray)
                }
                .padding(.trailing, 10)
                .disabled(disabled)
                
                Text(plan.name)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(disabled ? Color(.secondaryLabel) : Color(.label))
                
                Spacer()
                
                if plan != .free {
                    HStack(spacing: 0) {
                        Group {
                            Text(plan == .unlimited ? controller.unlimitedPeriod.period : plan.period)
                            + Text(" • ")
                        }
                        .foregroundColor(Color(.secondaryLabel))
                        
                        Text(controller.getPrice(for: plan))
                            .foregroundColor(Color(.label))
                    }
                }
                
                Button {
                    controller.expand(for: plan)
                } label: {
                    Image(systemName: controller.expandedPlan == plan ? "chevron.up" : "chevron.down")
                        .imageScale(.small)
                        .foregroundColor(Color(.secondaryLabel))
                }

            }
            .background(.clear)
            .onTapGesture {
                controller.expand(for: plan)
            }
            
            if controller.expandedPlan == plan {
                if plan == .unlimited {
                    HStack {
                        Spacer()
                        Picker("", selection: $controller.unlimitedPeriod) {
                            Text("monthly").tag(UnlimitedPeriod.monthly)
                            Text("annually").tag(UnlimitedPeriod.annually)
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 210)
                    }
                    .padding(.top)
                }
                
                VStack(alignment: .leading) {
                    Text(plan.description)
                        .foregroundColor(Color(.secondaryLabel))
                        .padding(.top, 5)
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("contents")
                        ForEach(plan.contents, id: \.self) { content in
                            Text(" • ") + Text(LocalizedStringKey(stringLiteral: content))
                        }
                    }
                }
                .padding(10)
            }
        }
        .frame(alignment: .top)
        .foregroundColor(Color(.label))
        .padding()
        .background(.regularMaterial)
        .cornerRadius(20)
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.blue, lineWidth: isSelected ? 2 : 0)
        }
        .shadow(color: (isSelected ? Color.blue : Color.black).opacity(0.25), radius: 15, y: 5)
        .padding(.vertical, 8)
        .padding(.horizontal)
        .animation(.spring(), value: isSelected)
        .animation(.spring(), value: controller.unlimitedPeriod)
    }
}

//struct PlanItem_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            PlanItem(planProduct: .free)
//            PlanItem(planProduct: .removeAds)
//            PlanItem(planProduct: .unlimitedMonthly)
//            Spacer()
//        }
//    }
//}
