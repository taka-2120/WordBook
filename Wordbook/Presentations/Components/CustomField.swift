//
//  CustomField.swift
//  WordBook
//
//  Created by Yu Takahashi on 4/2/23.
//

import SwiftUI

struct CustomField: View {
    let label: LocalizedStringKey
    var placeHolder: LocalizedStringKey? = nil
    var isSecured: Bool = false
    var isEmail: Bool = false
    var notes: LocalizedStringKey? = nil
    @Binding var text: String
    @Binding var isNoteShown: Bool
    
    init(_ label: LocalizedStringKey,
         placeHolder: LocalizedStringKey? = nil,
         isSecured: Bool = false,
         isEmail: Bool = false,
         notes: LocalizedStringKey? = nil,
         isNoteShown: Binding<Bool> = .constant(false),
         text: Binding<String>) {
        self.label = label
        self.placeHolder = placeHolder
        self.isSecured = isSecured
        self.isEmail = isEmail
        self.notes = notes
        self._isNoteShown = isNoteShown
        self._text = text
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(label)
                Spacer()
                
                if notes != nil {
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
            
            if isSecured {
                SecureField((placeHolder == nil) ? label : placeHolder!, text: $text)
                    .padding(.horizontal)
                    .padding(.vertical)
                    .background(Color(.systemGray5))
                    .cornerRadius(15)
            } else {
                TextField((placeHolder == nil) ? label : placeHolder!, text: $text)
                    .padding(.horizontal)
                    .padding(.vertical)
                    .background(Color(.systemGray5))
                    .cornerRadius(15)
                    .keyboardType(isEmail ? .emailAddress : .default)
                    .autocorrectionDisabled(isEmail)
                    .textInputAutocapitalization(isEmail ? .never : .sentences)
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

struct CustomField_Previews: PreviewProvider {
    static var previews: some View {
        CustomField("Field", notes: "Here is some notes.", text: .constant("Text"))
    }
}
