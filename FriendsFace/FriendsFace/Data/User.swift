//
//  User.swift
//  FriendsFace
//
//  Created by VITALI KAZLOU on 28.06.22.
//

import Foundation

struct User: Codable, Identifiable {
    
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}
