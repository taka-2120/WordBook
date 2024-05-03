//
//  View+DismissButton.swift
//  WordVenture
//
//  Created by Yu Takahashi on 3/29/24.
//

import SwiftUI

extension View {
    func dismissibleToolbar(_ customDismissAction: DismissAction? = nil) -> some View {
        modifier(ToolbarDismissButton(customDismissAction))
    }
}

fileprivate struct ToolbarDismissButton: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    let customDismissAction: DismissAction?
    
    init(_ customDismissAction: DismissAction?) {
        self.customDismissAction = customDismissAction
    }
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    DismissButton(customDismissAction != nil ? customDismissAction! : dismiss, colorScheme)
                }
            }
    }
}
