//
//  AppViewModel.swift
//  Flashzilla
//
//  Created by VITALI KAZLOU on 16.09.22.
//

import SwiftUI

extension MainView {
    class AppState: ObservableObject {
        @Published var cards = [Card](repeating: Card.test, count: 10)
        
        private(set) var timeRemaining = 100 {
            willSet {
                objectWillChange.send()
            }
        }
        
        var isAppActive = true
        
        func removeCard(at index: Int) {
            guard index < cards.count && index >= 0 else { return }
            
            cards.remove(at: index)
            
            if cards.isEmpty {
                isAppActive = false
            }
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
