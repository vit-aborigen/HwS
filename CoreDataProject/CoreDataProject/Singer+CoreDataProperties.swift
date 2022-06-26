//
//  Singer+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by VITALI KAZLOU on 26.06.22.
//
//

import Foundation
import CoreData


extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    
    var wrappedFirstName: String {
        firstName ?? "N/A"
    }
    
    var wrappedLastName: String {
        lastName ?? "N/A"
    }

}

extension Singer : Identifiable {

}
