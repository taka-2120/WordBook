//
//  LoadingView.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/25/23.
//

import SwiftUI
import GIFImage

struct LoadingView: View, Sendable {
    @StateObject private var controller = LoadingController()
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            GIFImage(source: .local(filePath: AssetUrl.bookGif.url), loop: .constant(false)) { _ in
                await controller.load()
            }
        }
        .fullScreenCover(isPresented: $controller.isPrivacyPolicyUpdated) {
            DocPromptView(docKind: .privacyPolicy)
        }
        .fullScreenCover(isPresented: $controller.isTermsAndConditionsUpdated) {
            DocPromptView(docKind: .termsAndConditions)
        }
        .alert(L10n.error.rawValue, isPresented: $controller.isErrorShown) {
            Text(L10n.ok.rawValue)
        } message: {
            Text(controller.errorMessage)
        }
        .environmentObject(controller)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
