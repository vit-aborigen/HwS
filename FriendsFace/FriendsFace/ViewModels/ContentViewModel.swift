//
//  ContentViewModel.swift
//  FriendsFace
//
//  Created by VITALI KAZLOU on 29.06.22.
//

import Foundation
import SwiftUI
import CoreData

class ContentViewModel: ObservableObject {
    @Environment(\.managedObjectContext) var moc
    @Published var users: [User] = Array<User> ()
    private var serverAddress = "https://www.hackingwithswift.com/samples/friendface.json"
    
    func getDataFromServer() async {
        if !users.isEmpty { return }
        
        do {
            guard let url = URL(string: serverAddress) else { return }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            URLSession.shared.dataTaskPublisher(for: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            try DispatchQueue.main.sync {
                self.users = try decoder.decode([User].self, from: data)
                
                for inetUser in users {
                    let user = CachedUser(context: moc)
                    user.copyFromInetUser(from: inetUser)
                }
                try moc.save()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
