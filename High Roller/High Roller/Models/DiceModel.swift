//
//  DiceModel.swift
//  High Roller
//
//  Created by VITALI KAZLOU on 29.09.22.
//

import Foundation

class Dice: Codable {
    var id: UUID
    let sides: Int
    var value: Int
    
    
    init(id: UUID = UUID(), sides: Int) {
        self.id = id
        self.sides = sides
        self.value = Int.random(in: 1...sides)
    }
    
    func roll() {
        self.value = Int.random(in: 1...sides)
    }
    
    static let example = Dice(sides: 6)
}
