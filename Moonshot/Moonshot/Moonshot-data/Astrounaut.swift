//
//  Astrounaut.swift
//  Moonshot
//
//  Created by VITALI KAZLOU on 15.06.22.
//

import Foundation

struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}
