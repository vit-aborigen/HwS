//
//  Favorites.swift
//  SnowSeeker
//
//  Created by VITALI KAZLOU on 4.10.22.
//

import Foundation

class Favorites: Codable, ObservableObject {
    private var resorts: Set<String>
    private var savePath = FileManager.documentsDirectory.appendingPathComponent("snowseeker_favorites.json")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            resorts = try JSONDecoder().decode(Set<String>.self, from: data)
        } catch {
            print("Failed to load data: ", error.localizedDescription)
            resorts = []
        }
    }
    
    func saveData() {
        do {
            let data = try JSONEncoder().encode(resorts)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Failed to encode data: ", error.localizedDescription)
        }
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        saveData()
    }
    
    func delete(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        saveData()
    }
}
