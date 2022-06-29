//
//  DataController.swift
//  FriendsFace
//
//  Created by VITALI KAZLOU on 29.06.22.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "UserModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data is failed to load: \(error.localizedDescription)")
                return
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
