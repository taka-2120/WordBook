//
//  DialogManager.swift
//  WordVenture
//
//  Created by Yu Takahashi on 3/29/24.
//

import SwiftUI

@MainActor
class DialogManager: ObservableObject {
    @Published var isShown = false
    @Published var title: LocalizedStringKey?
    @Published var message: LocalizedStringKey?
    @Published var primaryButtonLabel: LocalizedStringKey?
    @Published var primaryAction: (() -> Void)?
    @Published var primaryRole: ButtonRole?
    @Published var secondaryButtonLabel: LocalizedStringKey?
    @Published var secondaryAction: (() -> Void)?
    @Published var secondaryRole: ButtonRole?
    
    private func reset() {
        title = nil
        message = nil
        primaryButtonLabel = nil
        primaryAction = nil
        primaryRole = nil
        secondaryButtonLabel = nil
        secondaryAction = nil
        secondaryRole = nil
    }
    
    func showErrorDialog(message: LocalizedStringKey) {
        Task { @MainActor in
            reset()
            title = L10n.error.rawValue
            self.message = message
            primaryButtonLabel = L10n.ok.rawValue
            isShown = true
        }
    }
    
    func showOKDialog(
        title: LocalizedStringKey,
        message: LocalizedStringKey,
        onOK: @escaping () -> Void
    ) {
        Task { @MainActor in
            reset()
            self.title = title
            self.message = message
            primaryButtonLabel = L10n.ok.rawValue
            primaryAction = onOK
            isShown = true
        }
    }
    
    func showYesNoDialog(
        title: LocalizedStringKey,
        message: LocalizedStringKey,
        onYes: @escaping () -> Void,
        onNo: @escaping () -> Void
    ) {
        Task { @MainActor in
            reset()
            self.title = title
            self.message = message
            primaryButtonLabel = L10n.no.rawValue
            primaryAction = onNo
            primaryRole = .cancel
            secondaryButtonLabel = L10n.yes.rawValue
            secondaryAction = onYes
            secondaryRole = .destructive
            isShown = true
        }
    }
    
    @MainActor
    func showDialog(
        title: LocalizedStringKey,
        message: LocalizedStringKey,
        primaryLabel: LocalizedStringKey,
        onPrimary: @escaping () -> Void,
        secondaryLabel: LocalizedStringKey,
        onSecondary: @escaping () -> Void
    ) {
        Task { @MainActor in
            reset()
            self.title = title
            self.message = message
            primaryButtonLabel = primaryLabel
            primaryAction = onPrimary
            primaryRole = .cancel
            secondaryButtonLabel = secondaryLabel
            secondaryAction = onSecondary
            secondaryRole = .destructive
            isShown = true
        }
    }
}
