//
//  ContentView.swift
//  Hot Prospects
//
//  Created by VITALI KAZLOU on 1.09.22.
//

import SwiftUI

@MainActor class User: ObservableObject {
    @Published var userName = "test user"
}

struct MainView: View {
    @StateObject var user = User()
    
    var body: some View {
        VStack {
            EditView()
            DisplayView()
        }
        .environmentObject(user)
    }
}

struct EditView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        TextField("Name: ", text: $user.userName)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        Text(user.userName)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
