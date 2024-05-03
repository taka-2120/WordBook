//
//  IntroItem.swift
//  WordVenture
//
//  Created by Yu Takahashi on 3/29/24.
//

import SwiftUI

struct IntroItem: View {
    let image: ImageResource
    let description: LocalizedStringKey
    
    init(image: ImageResource, description: LocalizedStringKey) {
        self.image = image
        self.description = description
    }
    
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .cornerRadius(30)
            Text(description)
                .padding(.vertical)
        }
    }
}

#Preview {
    IntroItem(image: .brain, description: "")
}
