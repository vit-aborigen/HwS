//
//  Location.swift
//  BucketList
//
//  Created by VITALI KAZLOU on 17.07.22.
//

import Foundation
import CoreLocation

struct Location: Codable, Equatable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
    static let example = Location(id: UUID(), name: "Example name", description: "Description for a preview", latitude: 51.1, longitude: -0.14)
}
