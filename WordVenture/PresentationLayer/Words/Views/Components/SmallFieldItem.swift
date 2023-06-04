//
//  SmallFieldItem.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/30/23.
//

import SwiftUI

struct SmallFieldItem: View {
    
    let label: LocalizedStringKey
    @Binding var array: [String]
    let isEditing: Bool
    
    init(_ label: LocalizedStringKey, array: Binding<[String]>, isEditing: Bool = true) {
        self.label = label
        self._array = array
        self.isEditing = isEditing
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)
                .padding(.top, 10)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Array(array.enumerated()), id: \.offset) { index, word in
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
                            .background(Color(.tertiarySystemGroupedBackground))
                            .cornerRadius(15)
                        } else {
                            Text(array[index])
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .background(Color(.tertiarySystemGroupedBackground))
                                .cornerRadius(15)
                        }
                    }
                }
            }
        }
    }
}
