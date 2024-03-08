//
//  AddingFriendsView.swift
//  ContactPicker
//
//  Created by johndanial on 3/7/24.
//

import SwiftUI

struct AddingFriendsView: View {
    @EnvironmentObject var contactPermission: ContactPermission
    @Environment(\.dismiss) var dismiss
    @Binding var friends: [Contact]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(contactPermission.contacts) { contact in
                    ContactDetailView(contact: contact, friends: $friends)
                }
            }
            .toolbar {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
}
