//
//  DismissButton.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/27/23.
//

import SwiftUI

struct DismissButton: View {
    
    private let dismiss: DismissAction
    private let colorScheme: ColorScheme
    private let action: (() -> Void)?
    
    init(_ dismiss: DismissAction, _ colorScheme: ColorScheme, action: (() -> Void)? = nil) {
        self.dismiss = dismiss
        self.colorScheme = colorScheme
        self.action = action
    }
    
    var body: some View {
        Button {
            if let action = action {
                action()
            } else {
                dismiss()
            }
        } label: {
            ZStack {
                Circle()
                    .fill(Color(white: colorScheme == .dark ? 0.19 : 0.93))
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .font(.body)
                    .fontWeight(.bold)
                    .scaleEffect(0.416)
                    .foregroundStyle(Color(white: colorScheme == .dark ? 0.62 : 0.51))
            }
            .frame(width: 30, height: 30)
        }
    }
}
