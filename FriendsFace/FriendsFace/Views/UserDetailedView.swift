//
//  UserDetailedView.swift
//  FriendsFace
//
//  Created by VITALI KAZLOU on 28.06.22.
//

import SwiftUI

struct UserDetailedView: View {
    var user: User
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        List {
            Section {
                Text(user.about)
                    .padding(.vertical)
            } header: {
                Text("About")
            }
            
            Section {
                Text("Address: \(user.address)")
                Text("Company: \(user.company)")
            } header: {
                Text("Contact details")
            }
            
            Section {
                ForEach(user.friends) { friend in
                    Text(friend.name)
                }
            } header: {
                Text("Friends")
            }
        }
        .listStyle(.grouped)
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
