//
//  ImageButton.swift
//  WordVenture
//
//  Created by Yu Takahashi on 5/25/23.
//

import SwiftUI

struct RelatedImage: View {
    
    private let url: String
    private let height: CGFloat
    
    init(url: String, height: CGFloat = 150) {
        self.url = url
        self.height = height
    }
    
    var body: some View {
        AsyncImage(url: URL(string: url)!) { image in
            image
                .resizable()
                .scaledToFit()
                .cornerRadius(15)
        } placeholder: {
            ProgressView()
        }
        .frame(height: height)
        .padding(10)
        .shadow(color: .black.opacity(0.2), radius: 15, y: 4)
    }
}
