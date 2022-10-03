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
    
    static let example: Resort = (Bundle.main.decode("resorts.json") as [Resort])[0]
}
