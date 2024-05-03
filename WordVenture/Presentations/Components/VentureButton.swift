//
//  VentureButton.swift
//  WordVenture
//
//  Created by Yu Takahashi on 3/29/24.
//

import SwiftUI

struct VentureButton: View {
    let label: LocalizedStringKey
    let foregroundColor: Color
    let backgroundColor: Color
    let action: () -> Void
    
    init(
        label: LocalizedStringKey,
        foregroundColor: Color = Color(.systemBackground),
        backgroundColor: Color = Color(.label),
        action: @escaping () -> Void
    ) {
        self.label = label
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .foregroundColor(foregroundColor)
                .font(.title3)
                .padding()
                .frame(maxWidth: 250)
        }
        .background(backgroundColor)
        .cornerRadius(15)
    }
}

#Preview {
    VentureButton(label: "", action: {})
}
