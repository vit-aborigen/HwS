//
//  UserModel.swift
//  ConferenceFaces
//
//  Created by VITALI KAZLOU on 11.08.22.
//

import Foundation
import UIKit

struct User: Codable, Comparable, Hashable, Identifiable {
    var id = UUID()
    let fullName: String
    var lastTimeMeet: Date?

    static func <(lhs: User, rhs: User) -> Bool {
        lhs.fullName < rhs.fullName
    }
}

struct UserPhoto {
    let userID: UUID
    let photo: UIImage?
}
