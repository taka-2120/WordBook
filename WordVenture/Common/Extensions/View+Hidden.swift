//
//  ViewEx.swift
//  WordBook
//
//  Created by Yu Takahashi on 2022/07/03.
//

import SwiftUI

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

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


extension View {
    func isHidden(_ hidden: Bool, remove: Bool) -> some View {
        modifier(HiddenModifier(isHidden: hidden, remove: remove))
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
