//
//  CachedUser+CoreDataProperties.swift
//  FriendsFace
//
//  Created by VITALI KAZLOU on 29.06.22.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?
    
    var wrappedName: String {
        return name ?? ""
    }
    
    var wrappedStatus: Bool {
        isActive ?? false
    }
    
    var wrappedAge: Int {
        Int(age) ?? -1
    }
    
    var wrappedCompany: String {
        company ?? ""
    }

    var wrappedEmail: String {
        email ?? ""
    }
    
    var wrappedAddress: String {
        address ?? ""
    }
    
    var wrappedAbout: String {
        about ?? ""
    }
    
    var wrappedRegistered: Date {
        registered ?? Date.now
    }
    
    var wrappedTags: String {
        tags ?? ""
    }
    
    var wrappedFriends: [CachedFriend] {
        let friendsSet = friends as? Set<CachedFriend> ?? []
        return friendsSet.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for friends
extension CachedUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CachedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CachedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

    func copyFromInetUser(from inetUser: User) {
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
            let cachedFriend = CachedFriend(context: self.managedObjectContext!)
            cachedFriend.id = friend.id
            cachedFriend.name = friend.name
            self.addToFriends(cachedFriend)
        }
    }
}

extension CachedUser : Identifiable {

}
