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
        VStack(alignment: .leading, spacing: 15) {
            Text("plans")
                .font(.title)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
            
            ForEach(controller.products, id: \.self) { product in
                VStack {
                    Text(product.displayName)
                    Text("\(product.displayPrice)")
                }
            }

            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PlansView_Previews: PreviewProvider {
    static var previews: some View {
        PlansView()
    }
}
