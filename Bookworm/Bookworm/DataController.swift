//
//  DataController.swift
//  Bookworm
//
//  Created by VITALI KAZLOU on 22.06.22.
//

import Foundation
import CoreData

enum BookGenre: String, CaseIterable {
    case fantasy = "Fantasy"
    case horror = "Horror"
    case kids = "Kids"
    case mystery = "Mystery"
    case romance = "Romance"
    case thriller = "Thriller"
}

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")
    
    init () {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data is failed to load. \(error.localizedDescription)")
            }
        }
    }
}
