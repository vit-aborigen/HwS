//
//  GameViewModel.swift
//  RPS_simple_game
//
//  Created by VITALI KAZLOU on 7.06.22.
//

import Foundation

enum PossibleOutput: String, CaseIterable {
    case Win = "Win"
    case Lose = "Lose"
}

enum Figures: String, CaseIterable {
    case Rock = "Rock"
    case Paper = "Paper"
    case Scissors = "Scissors"
}

class Helper: ObservableObject {
    @Published var maxTurns: Int
    
    init (amountOfTurns: Int) {
        self.maxTurns = amountOfTurns
        
    }
}

class GameViewModel: ObservableObject {

}


