//
//  AppViewModel.swift
//  Flashzilla
//
//  Created by VITALI KAZLOU on 16.09.22.
//

import SwiftUI

extension MainView {
    @MainActor class AppState: ObservableObject {
        private var savePath = FileManager.documentsDirectory.appendingPathComponent("FlashZilla")
        @Published var cards: [Card] = []
        
        private(set) var timeRemaining = 100 {
            willSet {
                objectWillChange.send()
            }
        }
        
        var isAppActive = true
        
        func loadData() {
            do {
                let data = try Data(contentsOf: savePath.appendingPathComponent("cards.json"))
                cards = try JSONDecoder().decode([Card].self, from: data)
            } catch {
                print("Failed to load data", error.localizedDescription)
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
        
        func addCards(newCards: [Card]) {
            cards = newCards
            saveData()
        }
        
        func removeCard(at index: Int, permanently: Bool = false, reprocessLater: Bool = false) {
            guard index < cards.count, index >= 0 else { return }
            
            if reprocessLater {
                cards.moveToTheEnd()
            } else {
                cards.remove(at: index)
            }
            
            if permanently {
                saveData()
            }
            
            if cards.isEmpty {
                isAppActive = false
            }
        }
        
        func resetCards() {
            timeRemaining = 100
            isAppActive = true
            loadData()
        }
        
        func decreaseTimer() {
            timeRemaining -= 1
        }
    }
}
