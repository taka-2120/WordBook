//
//  View+Dialog.swift
//  WordVenture
//
//  Created by Yu Takahashi on 3/29/24.
//

import SwiftUI

extension View {
    @MainActor
    func dialog(manager: DialogManager) -> some View {
        modifier(DialogModifier(manager: manager))
    }
}

fileprivate struct DialogModifier: ViewModifier {
    @StateObject private var manager: DialogManager

    init(manager: DialogManager) {
        self._manager = StateObject(wrappedValue: manager)
    }

    func body(content: Content) -> some View {
        content
            .alert(manager.title ?? "", isPresented: $manager.isShown) {
                // Primary
                Button(
                    manager.primaryButtonLabel ?? "",
                    role: manager.primaryRole,
                    action: manager.primaryAction ?? { }
                )
                .disabled(false)
                
                // Secondary
                if manager.secondaryButtonLabel != nil {
                    Button(
                        manager.secondaryButtonLabel!,
                        role: manager.secondaryRole,
                        action: manager.secondaryAction ?? {}
                    )
                    .disabled(false)
                }
            } message: {
                Text(manager.message ?? "")
            }
    }
}
