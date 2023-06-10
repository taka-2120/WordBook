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
    
    let period: UnlimitedPeriod
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Image(systemName: controller.selectedPeriod == period ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(controller.selectedPeriod == period ? .green : .gray)
                    .padding(.trailing, 10)
                
                Group {
                    Text("Unlimited ")
                    + Text(LocalizedStringKey(stringLiteral: period.periodName))
                }
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color(.label))
                
                Spacer()
                
                HStack(spacing: 0) {
                    Group {
                        Text(LocalizedStringKey(stringLiteral: period.periodName))
                        + Text(" • ")
                    }
                    .foregroundColor(Color(.secondaryLabel))
                    
                    Text(controller.getPrice(for: period))
                        .foregroundColor(Color(.label))
                }
            }
            
            if controller.currentPeriod == period {
                HStack {
                    Label("Your plan", systemImage: "star")
                        .foregroundStyle(Color(.secondaryLabel))
                        .padding(.leading)
                    Spacer()
                }
            }
        }
        .foregroundColor(Color(.label))
        .padding()
        .background(.regularMaterial)
        .cornerRadius(20)
        .onTapGesture {
            controller.selectPeriod(for: period)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.blue, lineWidth: controller.selectedPeriod == period ? 2 : 0)
        }
        .shadow(color: (controller.selectedPeriod == period ? Color.blue : Color.black).opacity(0.25), radius: 15, y: 5)
        .padding(.vertical, 8)
        .padding(.horizontal)
        .animation(.spring(), value: controller.selectedPeriod)
        .animation(.spring(), value: controller.currentPeriod)
    }
}
