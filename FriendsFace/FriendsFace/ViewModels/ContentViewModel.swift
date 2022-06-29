//
//  ContentViewModel.swift
//  FriendsFace
//
//  Created by VITALI KAZLOU on 29.06.22.
//

import Foundation
import SwiftUI

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
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func cacheUsers (from usersFromInternet: [User]) {
        for inetUser in usersFromInternet {
            let cachedUser = CachedUser(context: moc)
            
            cachedUser.id = inetUser.id
            cachedUser.isActive = inetUser.isActive
            cachedUser.age = Int16(inetUser.age)
            cachedUser.company = inetUser.company
            cachedUser.email = inetUser.email
            cachedUser.address = inetUser.address
            cachedUser.about = inetUser.about
            cachedUser.registered = inetUser.registered
            cachedUser.tags = inetUser.tags.joined(separator: ",")
            
            for friend in inetUser.friends {
                let cachedFriend = CachedFriend(context: moc)
                cachedFriend.id = friend.id
                cachedFriend.name = friend.name
                cachedUser.addToFriends(cachedFriend)
            }
            
            try? moc.save()
        }
    }
}
