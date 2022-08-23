//
//  DataManager.swift
//  ConferenceFaces
//
//  Created by VITALI KAZLOU on 19.08.22.
//

import Foundation
import SwiftUI

class DataManager: ObservableObject {
    private var savePath = FileManager.documentsDirectory.appendingPathComponent("My Conferences")
    
    static let shared = DataManager()
    private var storage: [Conference]
    
    private init() {
        do {
            let data = try Data(contentsOf: savePath)
            storage = try JSONDecoder().decode([Conference].self, from: data)
        } catch {
            storage = []
        }
        
        if !FileManager.default.fileExists(atPath: savePath.path) {
            do {
                try FileManager.default.createDirectory(at: savePath, withIntermediateDirectories: true)
            } catch {
                print(error.localizedDescription)
                savePath = FileManager.documentsDirectory
            }
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
    
    func savePhoto(photo: UIImage, for user: User) {
        if let data = photo.jpegData(compressionQuality: 0.8) {
            let filename = savePath.appendingPathComponent("\(user.id).jpg")
            do {
                try data.write(to: filename)
            } catch {
                print("Failed to save user's photo \(error.localizedDescription)")
            }
        }
    }
    
    func loadPhoto(for user: User) -> UIImage {
        let filename = savePath.appendingPathComponent("\(user.id).jpg")
        
        if let image = UIImage(contentsOfFile: filename.path) {
            return image
        }
        return UIImage(systemName: "questionmark.circle")!
    }
}
