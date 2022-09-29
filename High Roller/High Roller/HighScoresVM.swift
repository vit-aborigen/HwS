//
//  HighScoresVM.swift
//  High Roller
//
//  Created by VITALI KAZLOU on 30.09.22.
//

import Foundation

class HighScoreVM: ObservableObject {
    @Published var scores: [Score]
    let savePath = FileManager.documentsDirectory.appendingPathComponent("highscores.json")

    init() {
        do {
            let data = try Data(contentsOf: savePath)
            scores = try JSONDecoder().decode([Score].self, from: data)
        } catch {
            print("Can't load the data", error.localizedDescription)
            scores = []
        }
    }
    
    func checkScores(newScore: Score) {
        if newScore.score > (scores.max {$0.score < $1.score})?.score ?? 0 {
            scores.append(newScore)
            saveData()
        }
    }
    
    private func saveData() {
        do {
            let data = try JSONEncoder().encode(scores)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Failed to save data: ", error.localizedDescription)
        }
    }
}
