//
//  DocPromptView.swift
//  WordVenture
//
//  Created by Yu Takahashi on 6/19/23.
//

import SwiftUI

struct DocPromptView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var controller: LoadingController
    
    private let docKind: DocKind
    
    init(docKind: DocKind) {
        self.docKind = docKind
    }
    
    var body: some View {
        ZStack {
            switch docKind {
            case .privacyPolicy:
                PrivacyPolicyView(date: controller.privacyPolicyUpdatedDate, needPadding: true)
            case .termsAndConditions:
                TermsAndConditionsView(date: controller.privacyPolicyUpdatedDate, needPadding: true)
            }
            
            GeometryReader { geo in
                VStack {
                    Spacer()
                    
                    HStack(spacing: 20) {
                        Button {
                            controller.disagree(for: docKind)
                        } label: {
                            Text("disagree")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: 250)
                        }
                        .background(.gray)
                        .cornerRadius(15)
                        .shadow(color: .gray.opacity(0.25), radius: 10, y: 4)
                        
                        Button {
                            controller.agree(for: docKind)
                        } label: {
                            Text("agree")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: 250)
                        }
                        .background(.blue)
                        .cornerRadius(15)
                        .shadow(color: .blue.opacity(0.25), radius: 10, y: 4)
                    }
                }
                .padding()
                .background {
                    VStack {
                        Rectangle()
                            .fill(.regularMaterial)
                            .frame(
                                minWidth: 0,
                                maxWidth: .infinity,
                                minHeight: geo.safeAreaInsets.top,
                                maxHeight: geo.safeAreaInsets.top)
                        Spacer()
                    }
                    .ignoresSafeArea()
                }
            }
        }
    }
}

struct DocPromptView_Previews: PreviewProvider {
    static var previews: some View {
        DocPromptView(docKind: .privacyPolicy)
    }
}
