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
        @Published var users: [User]
        
        var dataManager = DataManager.shared
        
        init() {
            conferences = dataManager.getConferencesList()
            users = dataManager.getUsersList()
        }

        func addConference(newConference: Conference) {
            conferences.append(newConference)
            dataManager.updateConferences(newData: conferences)
        }
        
        func addUser(newUser: User) {
            users.append(newUser)
            dataManager.updateUsers(newData: users)
        }

        func removeConference(at offset: IndexSet) {
            conferences.remove(atOffsets: offset)
            dataManager.updateConferences(newData: conferences)
        }
        
        func removeUsers(at offset: IndexSet) {
            users.remove(atOffsets: offset)
            dataManager.updateUsers(newData: users)
        }

        func updateConference(oldConference: Conference, newConference: Conference) {
            if let idx = conferences.firstIndex(of: oldConference) {
                conferences[idx] = newConference
            }
            dataManager.updateConferences(newData: conferences)
        }
        
        func updateUsers(oldUser: User, newUser: User) {
            if let idx = users.firstIndex(of: oldUser) {
                users[idx] = newUser
            }
            dataManager.updateUsers(newData: users)
        }
    }
}
