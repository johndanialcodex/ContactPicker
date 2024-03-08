//
//  ContactModel.swift
//  ContactPicker
//
//  Created by johndanial on 3/7/24.
//
import Contacts


actor ContactModel {
    private let contactStore = CNContactStore()
    
    public func requestPermission() async throws -> Bool {
        return try await contactStore.requestAccess(for: .contacts)
    }
    
    public func loadContacts() async throws -> [Contact] {
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey as CNKeyDescriptor
        ]
        let fetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch)
        var contacts = [CNContact]()
        try self.contactStore.enumerateContacts(with: fetchRequest) { contact, stop in
            contacts.append(contact)
        }
        return contacts.map { contact in
            _ = CNContactFormatter.string(from: contact, style: .fullName) ?? ""
            let phoneNumbers = contact.phoneNumbers.map { $0.value.stringValue }
            return Contact(givenName: contact.givenName, familyName: contact.familyName, phoneNumbers: phoneNumbers)
        }
    }
}


struct Contact: Identifiable {
    let id = UUID()
    let givenName: String
    let familyName: String
    let phoneNumbers: [String ]
}
