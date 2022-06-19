//
//  Tracker.swift
//  Habit tracker
//
//  Created by VITALI KAZLOU on 19.06.22.
//

import Foundation

class Tracker: ObservableObject {
    @Published var activities = Array<Activity> () {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "Activities")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Activities") {
            if let decodedItems = try? JSONDecoder().decode([Activity].self, from: savedItems) {
                self.activities = decodedItems
                return
            }
        }
        
        self.activities = []
    }
}
