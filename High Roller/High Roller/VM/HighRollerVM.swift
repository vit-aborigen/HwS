//
//  HighRollerVM.swift
//  High Roller
//
//  Created by VITALI KAZLOU on 29.09.22.
//

import Foundation

class AppState: ObservableObject {
    private var numberOfDices = 1
    private var numberOfSides = 6
    @Published var dices: [Dice] = []
    
    init() {
        for _ in 1...numberOfDices {
            dices.append(Dice(sides: numberOfSides))
        }
    }
    
    private func resetState() {
        dices = []
    }
    
    var score: Int {
        dices.reduce(0) { $0 + $1.value}
    }
    
    func returnScore() -> Score {
        Score(score: score, numberOfDices: numberOfDices, numberOfSides: numberOfSides, snapshot: dices)
    }
    
    private func generateDices() {
        for _ in 1...numberOfDices {
            dices.append(Dice(sides: numberOfSides))
        }
    }
    
    func reroll(dices: Int, sides: Int) {
        numberOfDices = dices
        numberOfSides = sides
        
        resetState()
        generateDices()
    }
}
