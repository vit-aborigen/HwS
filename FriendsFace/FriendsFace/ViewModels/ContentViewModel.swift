//
//  ContentViewModel.swift
//  FriendsFace
//
//  Created by VITALI KAZLOU on 29.06.22.
//

import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var users: [User] = Array<User> ()
    private var serverAddress = "https://www.hackingwithswift.com/samples/friendface.json"
    
    func getDataFromServer() async {
        if !users.isEmpty { return }
        
        do {
            guard let url = URL(string: serverAddress) else { return }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            URLSession.shared.dataTaskPublisher(for: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            try DispatchQueue.main.sync {
                self.users = try decoder.decode([User].self, from: data)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
