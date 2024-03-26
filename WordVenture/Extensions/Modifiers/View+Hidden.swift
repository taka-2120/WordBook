//
//  ViewEx.swift
//  WordBook
//
//  Created by Yu Takahashi on 2022/07/03.
//

import SwiftUI

extension View {
    func isHidden(_ hidden: Bool, remove: Bool) -> some View {
        modifier(HiddenModifier(isHidden: hidden, remove: remove))
    }
}

fileprivate struct HiddenModifier: ViewModifier {

    private let isHidden: Bool
    private let remove: Bool

    init(isHidden: Bool, remove: Bool) {
        self.isHidden = isHidden
        self.remove = remove
    }

    func body(content: Content) -> some View {
        VStack {
            if isHidden == true {
                if remove == true {
                    EmptyView()
                } else {
                    content.hidden()
                }
            } else {
                content
            }
        }
    }
}
