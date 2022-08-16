//
//  ConferenceViewModel.swift
//  ConferenceFaces
//
//  Created by VITALI KAZLOU on 13.08.22.
//

import Foundation

extension MainView {
    class ConferenceViewModel: ObservableObject {
        @Published private(set) var conferences: [Conference]
        let savePath = FileManager.documentsDirectory.appendingPathComponent("My conferences")

        init() {
            do {
                let data = try Data(contentsOf: savePath)
                conferences = try JSONDecoder().decode([Conference].self, from: data)
            } catch {
                conferences = []
            }
        }

        func addConference(newConference: Conference) {
            conferences.append(newConference)
            saveData()
        }

        func removeConference(at offset: IndexSet) {
            conferences.remove(atOffsets: offset)
            saveData()
        }

        func updateConference(oldConference: Conference, newConference: Conference) {
            if let idx = conferences.firstIndex(of: oldConference) {
                conferences[idx] = newConference
            }
            saveData()
        }

        func saveData() {
            do {
                let data = try JSONEncoder().encode(conferences)
                try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Failed to store conferences")
            }
        }
    }
}
