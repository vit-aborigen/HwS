//
//  ConferenceViewModel.swift
//  ConferenceFaces
//
//  Created by VITALI KAZLOU on 13.08.22.
//

import Foundation

extension MainView {
    @MainActor class ConferenceViewModel: ObservableObject {
        @Published private(set) var conferences: Array<Conference>
        
        init() {
            conferences = []
        }
        
        func addConference(name: String, place: String, date: Date, attendees: [User] = []) {
            let newConference = Conference(name: name, place: place, date: date, attendees: attendees)
            conferences.append(newConference)
        }
        
        func removeConference(at offset: IndexSet) {
            conferences.remove(atOffsets: offset)
        }
    }
}
