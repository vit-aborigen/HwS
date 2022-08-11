//
//  ConferenceModel.swift
//  ConferenceFaces
//
//  Created by VITALI KAZLOU on 11.08.22.
//

import Foundation

struct Conference: Identifiable, Comparable {
    let id = UUID()
    let name: String
    let place: String
    let date: Date
    let attendees: Array<User>
    
    static func < (lhs: Conference, rhs: Conference) -> Bool {
        lhs.name < rhs.name
    }
    
    static var example: Conference {
        Conference(name: "Test Conf", place: "Berlin", date: Date.now, attendees: [User(fullName: "Anton"), User(fullName: "Aza")])
    }
}
