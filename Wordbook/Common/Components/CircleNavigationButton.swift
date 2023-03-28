//
//  CircleNavigationButton.swift
//  WordBook
//
//  Created by Yu Takahashi on 2022/07/03.
//

import SwiftUI

struct CircleNavigationButton: View {
    @Binding var isShown: Bool
    var icon: String
    var detents: Set<PresentationDetent>
    var destination: AnyView
    
    var body: some View {
        Button(action: {
            isShown.toggle()
        }, label: {
            Image(systemName: icon)
                .foregroundColor(Color("AccentColor"))
                .font(.title2)
        })
        .frame(minWidth: 55, minHeight: 55)
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(30)
        .shadow(color: Color(.systemGray4), radius: 8, x: 2, y: 2)
        
        .sheet(isPresented: $isShown) {
            destination
                .presentationDetents(detents)
        }
    }
}

struct CircleNavigationButton_Previews: PreviewProvider {
    static var previews: some View {
        CircleNavigationButton(
            isShown: .constant(false),
            icon: "gearshape.fill",
            detents: [.large],
            destination: AnyView(EmptyView())
        )
    }
}
