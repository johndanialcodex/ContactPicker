//
//  ContactsView.swift
//  ContactPicker
//
//  Created by johndanial on 3/7/24.
//

import SwiftUI


struct ContactsView: View {
    
    @EnvironmentObject var contactPermission: ContactPermission

    @State private var friendName = ""
    @State private var friends = [Contact]()

    @State private var addingNewFriendFromContacts = false
    @State private var triedToImportContactsWithoutPermission = false

    
    var body: some View {
        
        NavigationStack {
            List(friends) { contact in
                VStack{
                    HStack(spacing: 7) {
                        Text(contact.givenName)
                        Text(" ")
                        Text(contact.familyName)
                    }
                    Spacer()
                    Spacer()
                    
                    HStack {
                        ForEach(contact.phoneNumbers, id: \.self) { phoneNumber in
                            Text(phoneNumber)
                        }
                    }
                }
            }
                
            .sheet(isPresented: $addingNewFriendFromContacts) {
                AddingFriendsView(friends: $friends)
            }
            .navigationTitle("Friends")
            .toolbar {
                Button {
                    
                  
                    Task {
                        await contactPermission.requestContactsPermission()
                    }

                    
                addingNewFriendFromContacts = true
                    
                } label: {
                    Label("Add New Friend", systemImage: "plus")
                }
            }
        }

    }
    func addFriend() {
        friends.append(Contact(givenName: friendName, familyName: "", phoneNumbers: [""]))
    }
}

#Preview {
    ContactsView()
}
