//
//  ConferenceViewModel.swift
//  ConferenceFaces
//
//  Created by VITALI KAZLOU on 13.08.22.
//

import Foundation
import SwiftUI

extension MainView {
    class AppState: ObservableObject {
        @Published var conferences: [Conference]

        var dataManager = DataManager.shared

        init() {
            conferences = dataManager.getConferencesList()
        }

        func addConference(newConference: Conference) {
            conferences.append(newConference)
            dataManager.updateConferences(newData: conferences)
        }

        func removeConference(at offset: IndexSet) {
            conferences.remove(atOffsets: offset)
            dataManager.updateConferences(newData: conferences)
        }

        func updateConference(oldConference: Conference, newConference: Conference) {
            if let idx = conferences.firstIndex(of: oldConference) {
                conferences[idx] = newConference
            }
            dataManager.updateConferences(newData: conferences)
        }
    }
}
