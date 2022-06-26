//
//  DataController.swift
//  CoreDataProject
//
//  Created by VITALI KAZLOU on 26.06.22.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "DataModel")
    
    init () {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data is failed to load. \(error.localizedDescription)")
            }
        }
    }
}
