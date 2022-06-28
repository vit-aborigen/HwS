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
    
    private var serverAddress = "https://www.hackingwithswift.com/samples/friendface.json"
    
    var body: some View {
        NavigationView {
            UserList(users: users)
                .navigationTitle("Friends' face")
                .task {
                    await(getDataFromServer(from: serverAddress))
                }
        }
    }
    
    func getDataFromServer(from server: String) async {
        if !users.isEmpty { return }
        
        guard let url = URL(string: server) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let data = data, error == nil {
                do {
                    users = try decoder.decode([User].self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
        task.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
