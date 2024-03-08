//
//  ContactPermission.swift
//  ContactPicker
//
//  Created by johndanial on 3/7/24.
//

import Foundation
import UIKit

@MainActor
class ContactPermission: ObservableObject {
    @Published var contacts: [Contact] = []
    @Published var hasContactsPermission = false
    
    private let contactModel = ContactModel()
    
    public func requestContactsPermission() async {
        do {
            self.hasContactsPermission = try await contactModel.requestPermission()
            self.contacts = try await contactModel.loadContacts()
        } catch {
            print(error.localizedDescription)
        }
    }
}
