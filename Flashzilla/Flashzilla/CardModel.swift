//
//  CardModel.swift
//  Flashzilla
//
//  Created by VITALI KAZLOU on 16.09.22.
//

import Foundation

struct Card: Codable, Hashable {
    var question: String
    var answer: String
    
    static let test = Card(question: "Where is detonator?", answer: "In a car")
}
