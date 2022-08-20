//
//  DataManager.swift
//  ConferenceFaces
//
//  Created by VITALI KAZLOU on 19.08.22.
//

import Foundation
import SwiftUI

class DataManager: ObservableObject {
    let savePath = FileManager.documentsDirectory.appendingPathComponent("My conferences")
    private var storage: [Conference]
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            storage = try JSONDecoder().decode([Conference].self, from: data)
        } catch {
            storage = []
        }
    }
    
    private func saveData() {
        do {
            let data = try JSONEncoder().encode(storage)
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Failed to store conferences")
        }
    }
    
    func getData() -> [Conference] {
        storage
    }
    
    func updateData(newData: [Conference]) {
        storage = newData
        saveData()
    }
}
