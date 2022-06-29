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
    
    var body: some View {
        NavigationView {
            UserList(users: vm.users)
                .navigationTitle("Friends' face")
                .task {
                    await(vm.getDataFromServer())
                }
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
