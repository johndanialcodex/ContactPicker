//
//  ContactDetailView.swift
//  ContactPicker
//
//  Created by johndanial on 3/7/24.
//
import SwiftUI

struct ContactDetailView: View {
    let contact: Contact
    
    @State private var isSelected: Bool
    @Binding var friends: [Contact]
    
    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                            isSelected.toggle()
                            
                        }) {
                            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(isSelected ? .blue : .gray)
                                .imageScale(.large)
                        }
                        .padding(.trailing)
                        
               
            VStack(alignment: .leading) {
                Text("\(contact.givenName) \(contact.familyName)")
                ForEach(contact.phoneNumbers, id: \.self) { phoneNumber in
                    Text(phoneNumber)
                }
            }
           
        }
        
        .onChange(of: isSelected) { _, newValue in
            if friends.contains(where: { $0.id == contact.id }) {
                friends = friends.filter { $0.id != contact.id }
            } else {
                friends.append(contact)
            }
        }
    }
    
    init(contact: Contact, friends: Binding<[Contact]>) {
        self.contact = contact
        _friends = friends
        if friends.contains(where: { $0.id == contact.id }) {
            _isSelected = .init(initialValue: true)
        } else {
            _isSelected = .init(initialValue: false)
        }
    }
}

struct ContactDetailView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ContactDetailView(contact: .init(givenName: "John", familyName: "Danial", phoneNumbers: ["1234567890"]), friends: .constant([]))
            ContactDetailView(contact: .init(givenName: "Stevin", familyName: "Jackson", phoneNumbers: ["0987654321"]), friends: .constant([]))
        }
    }
}
