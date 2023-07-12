//
//  ImageButton.swift
//  WordVenture
//
//  Created by Yu Takahashi on 5/25/23.
//

import SwiftUI
import NukeUI

struct SelectableRelatedImage: View {
    
    @Binding private var selectedIndex: Int
    private let index: Int
    private let url: String
    private let height: CGFloat
    
    init(url: String, index: Int, selectedIndex: Binding<Int>, height: CGFloat = 150) {
        self.url = url
        self.index = index
        self._selectedIndex = selectedIndex
        self.height = height
    }
    
    var body: some View {
        ZStack {
            LazyImage(url: URL(string: url)!) { state in
                if let image = state.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if state.error != nil {
                    VStack {
                        Spacer()
                        Image(systemName: "xmark.fill")
                            .font(.system(size: 32))
                            .foregroundStyle(.red)
                        Spacer()
                    }
                    .frame(width: 200, height: height)
                    .background(Color(.systemBackground))
                } else {
                    ProgressView()
                        .frame(width: 200, height: height)
                        .background(Color(.systemBackground))
                }
            }
            .pipeline(customPipeline)
            .frame(height: height)
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.2), radius: 15, y: 4)
            .onTapGesture {
                selectedIndex = index
            }
            
            if selectedIndex == index {
                VStack {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .imageScale(.large)
                            .foregroundStyle(.green)
                            .background(
                                Color.white.mask(Circle())
                            )
                            .shadow(color: .green.opacity(0.3), radius: 10)
                            .padding(10)
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
        .padding(10)
        .animation(.bouncy, value: selectedIndex)
    }
}

struct RelatedImage: View {
    
    private let url: String
    private let height: CGFloat
    
    init(url: String, height: CGFloat = 150) {
        self.url = url
        self.height = height
    }
    
    var body: some View {
        LazyImage(url: URL(string: url)!) { state in
            if let image = state.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if state.error != nil {
                VStack {
                    Spacer()
                    Image(systemName: "xmark.fill")
                        .font(.system(size: 32))
                        .foregroundStyle(.red)
                    Spacer()
                }
                .frame(width: 200, height: height)
                .background(Color(.systemBackground))
            } else {
                ProgressView()
                    .frame(width: 200, height: height)
                    .background(Color(.systemBackground))
            }
        }
        .pipeline(customPipeline)
        .frame(height: height)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.2), radius: 15, y: 4)
        .padding(10)
    }
}
