//
//  Resort.swift
//  SnowSeeker
//
//  Created by VITALI KAZLOU on 3.10.22.
//

import Foundation

struct Resort: Codable, Identifiable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    var facilityImage: [Facility] {
        facilities.map(Facility.init)
    }

    var sizeString: String {
        switch size {
        case 1: return "Small"
        case 2: return "Medium"
        case 3: return "Large"
        default: return "No info"
        }
    }
    
    var priceString: String {
        switch price {
        case 1: return "$"
        case 2: return "$$"
        case 3: return "$$$"
        default: return "?"
        }
    }

    static let example: Resort = (Bundle.main.decode("resorts.json") as [Resort])[0]
}
