//
//  FriendsFaceApp.swift
//  FriendsFace
//
//  Created by VITALI KAZLOU on 28.06.22.
//

import SwiftUI

@main
struct FriendsFaceApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
