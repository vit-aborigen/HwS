//
//  ConferenceModel.swift
//  ConferenceFaces
//
//  Created by VITALI KAZLOU on 11.08.22.
//

import Foundation

struct Conference: Codable, Comparable, Identifiable {
    static func == (lhs: Conference, rhs: Conference) -> Bool {
        lhs.id == rhs.id
    }
    
    var id = UUID()
    var name: String
    var place: String
    var date: Date
    var attendees: Array<User>
    var location: Location?
    
    static func < (lhs: Conference, rhs: Conference) -> Bool {
        lhs.name < rhs.name
    }
    
    static var example: Conference {
        Conference(name: "Test Conf", place: "Berlin", date: Date.now, attendees: [User(fullName: "Anton"), User(fullName: "Aza")])
    }
}
