//
//  HighScoreModel.swift
//  High Roller
//
//  Created by VITALI KAZLOU on 29.09.22.
//

import Foundation

class Score: Identifiable, Codable {
    let score: Int
    let numberOfDices: Int
    let numberOfSides: Int
    let snapshot: [Dice]
    let time: Date
    
    var snapshotString: String {
        snapshot.reduce("") { $0 + " \($1.value)" }
    }
    
    init(score: Int, numberOfDices: Int, numberOfSides: Int, snapshot: [Dice]) {
        self.score = score
        self.numberOfDices = numberOfDices
        self.numberOfSides = numberOfSides
        self.snapshot = snapshot
        self.time = Date.now
    }
    
    static let example = Score(score: 18, numberOfDices: 3, numberOfSides: 6, snapshot: [Dice(sides: 6), Dice(sides: 6), Dice(sides: 6)])
}
