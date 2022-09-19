//
//  AppViewModel.swift
//  Flashzilla
//
//  Created by VITALI KAZLOU on 16.09.22.
//

import SwiftUI

extension MainView {
    class AppState: ObservableObject {
        private var savePath = FileManager.documentsDirectory.appendingPathComponent("FlashZilla")
        @Published var cards: [Card]
        
        private(set) var timeRemaining = 100 {
            willSet {
                objectWillChange.send()
            }
        }
        
        var isAppActive = true
        
        init() {
            if !FileManager.default.fileExists(atPath: savePath.absoluteString) {
                do {
                    try FileManager.default.createDirectory(at: savePath, withIntermediateDirectories: true)
                } catch {
                    print(error.localizedDescription)
                    savePath = FileManager.documentsDirectory
                }
            }
            
            do {
                let data = try Data(contentsOf: savePath.appendingPathExtension("cards.json"))
                cards = try JSONDecoder().decode([Card].self, from: data)
            } catch {
                print("Failed to load data")
                cards = []
            }
        }
        
        func saveData() {
            do {
                let data = try JSONEncoder().encode(cards)
                try data.write(to: savePath.appendingPathComponent("cards.json"), options: [.atomic, .completeFileProtection])
            } catch {
                print("Failed to store a data", error.localizedDescription)
            }
        }
        
        func addCard(question: String, answer: String) {
            cards.append(Card(question: question, answer: answer))
            saveData()
        }
        
        func removeCard(at index: Int) {
            guard index < cards.count && index >= 0 else { return }
            
            cards.remove(at: index)
            
            if cards.isEmpty {
                isAppActive = false
            }
            
            saveData()
        }
        
        func resetCards() {
            cards = [Card](repeating: Card.test, count: 10)
            timeRemaining = 100
            isAppActive = true
        }
        
        func decreaseTimer() {
            timeRemaining -= 1
        }
    }
}
