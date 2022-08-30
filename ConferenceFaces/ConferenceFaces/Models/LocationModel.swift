//
//  LocationModel.swift
//  ConferenceFaces
//
//  Created by VITALI KAZLOU on 30.08.22.
//

import Foundation
import CoreLocation

struct Location: Codable, Identifiable {
    var id: UUID
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    
    static let example = Location(id: UUID(), latitude: 51.1, longitude: -0.14)
}

