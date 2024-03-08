//
//  ContentView.swift
//  ContactPicker
//
//  Created by johndanial on 3/7/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var contactPermission = ContactPermission()
    
    var body: some View {
        TabView {
            ContactsView()
            
                .environmentObject(contactPermission)
            
//                .task {
//                    await
//                    contactPermission.requestContactsPermission()
//                    
//                    
//                }
        }
    }
}

#Preview {
    ContentView()
}

