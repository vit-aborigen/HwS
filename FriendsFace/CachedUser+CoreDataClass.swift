//
//  CachedUser+CoreDataClass.swift
//  FriendsFace
//
//  Created by VITALI KAZLOU on 29.06.22.
//
//

import Foundation
import CoreData
import SwiftUI

@objc(CachedUser)
public class CachedUser: NSManagedObject {
    @Environment(\.managedObjectContext) var moc
/*
    init(from inetUser: User) {
        
        self.id = inetUser.id
        self.isActive = inetUser.isActive
        self.age = Int16(inetUser.age)
        self.company = inetUser.company
        self.email = inetUser.email
        self.address = inetUser.address
        self.about = inetUser.about
        self.registered = inetUser.registered
        self.tags = inetUser.tags.joined(separator: ",")
        
        for friend in inetUser.friends {
            let cachedFriend = CachedFriend(context: moc)
            cachedFriend.id = friend.id
            cachedFriend.name = friend.name
            self.addToFriends(cachedFriend)
        }
        
        try? moc.save()
    }
*/
}
