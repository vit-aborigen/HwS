//
//  CacheModel.swift
//  FriendsFace
//
//  Created by VITALI KAZLOU on 29.06.22.
//

import CoreData
import Foundation
import SwiftUI

class CacheModel: ObservableObject {
    /*
    @Environment(\.managedObjectContext) var moc
    var internetUser: User
    var cachedUser: CachedUser
    
    func cacheUser(inetUser: User, cachedUser: CachedUser) {
        cachedUser.id = inetUser.id
        cachedUser.isActive = inetUser.isActive
        cachedUser.age = Int16(inetUser.age)
        cachedUser.company = inetUser.company
        cachedUser.email = inetUser.email
        cachedUser.address = inetUser.address
        cachedUser.about = inetUser.about
        cachedUser.registered = inetUser.registered
        cachedUser.tags = internetUser.tags.joined(separator: ",")
        
        for friend in inetUser.friends {
            let cachedFriend = CachedFriend(context: moc)
            cachedFriend.id = friend.id
            cachedFriend.name = friend.name
            cachedUser.addToFriends(cachedFriend)
        }
    }
    
    try? moc.save()
    */
}
