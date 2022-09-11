//
//  ProspectsViewModel.swift
//  Hot Prospects
//
//  Created by VITALI KAZLOU on 6.09.22.
//

import SwiftUI

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    
    private var savePath = FileManager.documentsDirectory.appendingPathComponent("Hot Prospects")
    
    init() {
        if !FileManager.default.fileExists(atPath: savePath.path) {
            do {
                try FileManager.default.createDirectory(at: savePath, withIntermediateDirectories: true)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        do {
            let data = try Data(contentsOf: savePath.appendingPathComponent("prospects.json"))
            people = try JSONDecoder().decode([Prospect].self, from: data)
        } catch {
            people = []
        }
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    func addPerson(person: Prospect) {
        people.append(person)
        save()
    }
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: savePath.appendingPathComponent("prospects.json"), options: [.atomicWrite, .completeFileProtection])
        } catch {
            print(savePath, error.localizedDescription)
        }
            
    }
}
