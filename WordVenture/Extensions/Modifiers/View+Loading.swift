//
//  View+Loading.swift
//  WordBook
//
//  Created by Yu Takahashi on 5/2/23.
//

import SwiftfulLoadingIndicators
import SwiftUI

extension View {
    func loading(_ isLoading: Binding<Bool>) -> some View {
        ZStack {
            self
            
            if isLoading.wrappedValue {
                ZStack {
                    Color(.systemGray6)
                        .opacity(0.4)
                        .ignoresSafeArea()
                    VStack {
                        LoadingIndicator(animation: .fiveLinesWave, color: Color(.label), size: .medium, speed: .normal)
                    }
                }
                .zIndex(0.9)
            }
        }
    }
}
