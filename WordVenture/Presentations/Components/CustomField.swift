//
//  CustomField.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/2/23.
//

import SwiftUI

enum KeyType {
    case normal
    case email
    case password
}

struct CustomField: View {
    @State private var isNoteShown = false
    
    private let label: LocalizedStringKey
    private let placeHolder: LocalizedStringKey?
    private let leadingIcon: String?
    private let keyType: KeyType
    private let notes: LocalizedStringKey?
    @Binding private var text: String
    
    init(_ label: LocalizedStringKey,
         placeHolder: LocalizedStringKey? = nil,
         leadingIcon: String? = nil,
         keyType: KeyType = .normal,
         notes: LocalizedStringKey? = nil,
         text: Binding<String>
    ) {
        self.label = label
        self.placeHolder = placeHolder
        self.leadingIcon = leadingIcon
        self.keyType = keyType
        self.notes = notes
        self._text = text
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(label)
                Spacer()
                
                if let notes = notes {
                    Button {
                        isNoteShown.toggle()
                    } label: {
                        Image(systemName: "info.circle")
                            .font(.body)
                            .padding(.trailing)
                    }
                }
            }
            .foregroundColor(Color(.secondaryLabel))
            .padding(.horizontal)
            
            HStack {
                if let leadingIcon = leadingIcon {
                    Image(systemName: leadingIcon)
                }
                
                if keyType == .password {
                    SecureField((placeHolder == nil) ? label : placeHolder!, text: $text)
                        .padding(.horizontal)
                        .padding(.vertical)
                        .background(Color(.tertiarySystemGroupedBackground))
                        .cornerRadius(15)
                } else {
                    TextField((placeHolder == nil) ? label : placeHolder!, text: $text)
                        .padding(.horizontal)
                        .padding(.vertical)
                        .background(Color(.tertiarySystemGroupedBackground))
                        .cornerRadius(15)
                        .keyboardType(keyType == .email ? .emailAddress : .default)
                        .autocorrectionDisabled(keyType == .email)
                        .textInputAutocapitalization(keyType == .email ? .never : .sentences)
                }
            }
            
            if notes != nil && isNoteShown {
                HStack {
                    Spacer()
                    Text(notes!)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.trailing)
                        .font(.callout)
                        .foregroundColor(Color(.secondaryLabel))
                        .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    CustomField("", placeHolder: "", notes: "", text: .constant(""))
}
