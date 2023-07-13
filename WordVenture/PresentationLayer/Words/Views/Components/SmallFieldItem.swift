//
//  SmallFieldItem.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/30/23.
//

import SwiftUI

struct SmallFieldItem: View {
    
    @Binding private var array: [String]
    private let label: LocalizedStringKey
    private let isEditing: Bool
    private let fillColor: Color
    
    init(_ label: LocalizedStringKey,
         array: Binding<[String]>,
         isEditing: Bool = true,
         fillColor: Color = Color(.secondarySystemFill)) {
        
        self.label = label
        self._array = array
        self.isEditing = isEditing
        self.fillColor = fillColor
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)
                .padding(.top, 10)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Array(array.enumerated()), id: \.offset) { index, word in
                        Group {
                            if isEditing {
                                HStack {
                                    Button {
                                        array.remove(at: index)
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(Color(.systemGray))
                                            .imageScale(.small)
                                    }

                                    TextField(label, text: $array[index])
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                .padding(10)
                            } else {
                                Text(array[index])
                                    .padding(.vertical, 10)
                                    .padding(.horizontal)
                            }
                        }
                        .background(fillColor)
                        .cornerRadius(15)
                    }
                }
            }
            .cornerRadius(15)
        }
    }
}
