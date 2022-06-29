//
//  ContentView.swift
//  FriendsFace
//
//  Created by VITALI KAZLOU on 28.06.22.
//

import SwiftUI

struct ContentView: View {
    @State private var users = Array<User>()
    @State private var result = ""
    @StateObject var vm = ContentViewModel()
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var fetchResults: FetchedResults<CachedFriend>
    
    var body: some View {
        NavigationView {
            HStack {
                UserList(users: vm.users)
                    .navigationTitle("Friends' face")
                    .task {
                        await(vm.getDataFromServer())
                        vm.cacheUsers(from: users)
                    }
                
                List(fetchResults, id: \.self) { user in
                    Text(user.wrappedName)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
