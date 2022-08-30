//
//  UserListModel.swift
//  ConferenceFaces
//
//  Created by VITALI KAZLOU on 27.08.22.
//

import Foundation

class UserListVM: ObservableObject {
    static let shared = UserListVM()
    @Published var users: [User]
    var dataManager = DataManager.shared

    private init() {
        users = dataManager.getUsersList()
    }

    func addUser(newUser: User) {
        users.append(newUser)
        dataManager.updateUsers(newData: users)
    }

    func removeUsers(at offset: IndexSet) {
        users.remove(atOffsets: offset)
        dataManager.updateUsers(newData: users)
    }

    func updateUsers(oldUser: User, newUser: User) {
        if let idx = users.firstIndex(of: oldUser) {
            users[idx] = newUser
        }
        dataManager.updateUsers(newData: users)
    }
}
