//
//  HighScoreModel.swift
//  High Roller
//
//  Created by VITALI KAZLOU on 29.09.22.
//

import Foundation

class Score: Codable {
    let numberOfDices: Int
    let numberOfSides: Int
    let snapshot: [Dice]
    let time: Date
    
    var snapshotString: String {
        snapshot.reduce("") { $0 + " \($1.value)" }
    }

    var score: Int {
        snapshot.reduce(0) { $0 + $1.value}
    }
    
    init(numberOfDices: Int, numberOfSides: Int, snapshot: [Dice]) {
        self.numberOfDices = numberOfDices
        self.numberOfSides = numberOfSides
        self.snapshot = snapshot
        self.time = Date.now
    }
    
    static let example = Score(numberOfDices: 3, numberOfSides: 6, snapshot: [Dice(sides: 6), Dice(sides: 6), Dice(sides: 6)])
}
