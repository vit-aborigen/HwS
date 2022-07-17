//
//  Location.swift
//  BucketList
//
//  Created by VITALI KAZLOU on 17.07.22.
//

import Foundation

struct Location: Codable, Equatable, Identifiable {
    var id: UUID
    let name: String
    let description: String
    let latitude: Double
    let longitude: Double
}

/*
struct tmp {
    let name: String
}

struct ComplexOne: Codable {
    var property: tmp
    
    enum CodingKeys: String, CodingKeys {
        case property
    }
}
*/
