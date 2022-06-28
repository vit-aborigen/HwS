//
//  UserList.swift
//  FriendsFace
//
//  Created by VITALI KAZLOU on 28.06.22.
//

import SwiftUI

struct UserList: View {
    var users: [User]
    
    var body: some View {
        List (users) { user in
            NavigationLink {
                UserDetailedView(user: user)
            } label: {
                HStack(alignment: .center) {
                    Circle()
                        .foregroundColor(user.isActive ? .green : .gray)
                        .frame(width: 10)
                    
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)
                        
                        Text(String(user.age))
                            .font(.headline)
                        
                        Text(user.company)
                    }
                }
            }
        }
    }
}
