//
//  KnownUsersView.swift
//  ConferenceFaces
//
//  Created by VITALI KAZLOU on 28.08.22.
//

import SwiftUI

struct KnownUsersView: View {
    var onAdd: (User) -> Void
    
    var body: some View {
        ForEach(UserListVM.shared.users, id: \.id) { user in
            HStack {
                Image(uiImage: DataManager.shared.loadPhoto(for: user))
                
                VStack {
                    Text(user.fullName)
                    Text("\(user.lastTimeMeet ?? Date.now, format: .dateTime)")
                }
                
                Button {
                    onAdd(user)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct KnownUsersView_Previews: PreviewProvider {
    static var previews: some View {
        KnownUsersView(onAdd: {_ in})
    }
}
