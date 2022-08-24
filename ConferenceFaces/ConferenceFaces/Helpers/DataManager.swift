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
    private var confStorage: [Conference]
    private var userStorage: [User]
    
    private init() {
        if !FileManager.default.fileExists(atPath: savePath.path) {
            do {
                try FileManager.default.createDirectory(at: savePath, withIntermediateDirectories: true)
            } catch {
                print(error.localizedDescription)
                savePath = FileManager.documentsDirectory
            }
        }
        
        do {
            let confData = try Data(contentsOf: savePath.appendingPathComponent("conf_list.json"))
            let userData = try Data(contentsOf: savePath.appendingPathComponent("user_list.json"))
            confStorage = try JSONDecoder().decode([Conference].self, from: confData)
            userStorage = try JSONDecoder().decode([User].self, from: userData)
        } catch {
            confStorage = []
            userStorage = []
        }
    }
    
    private func saveConferences() {
        do {
            let confData = try JSONEncoder().encode(confStorage)
            try confData.write(to: savePath.appendingPathComponent("conf_list.json"), options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Failed to store conferences", (error.localizedDescription))
        }
    }
    
    private func saveUsers() {
        do {
            let userData = try JSONEncoder().encode(userStorage)
            try userData.write(to: savePath.appendingPathComponent("user_list.json"), options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Failed to store users", (error.localizedDescription))
        }
    }
    
    func getConferencesList() -> [Conference] {
        confStorage
    }
    
    func getUsersList() -> [User] {
        userStorage
    }
    
    func updateConferences(newData: [Conference]) {
        confStorage = newData
        saveConferences()
    }
    
    func updateUsers(newData: [User]) {
        userStorage = newData
        saveUsers()
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
    
    func loadPhoto(for user: User?) -> UIImage {
        if let user = user {
            let filename = savePath.appendingPathComponent("\(user.id).jpg")
            
            if let image = UIImage(contentsOfFile: filename.path) {
                return image
            }
        }
        return UIImage(systemName: "questionmark.circle")!
    }
}
