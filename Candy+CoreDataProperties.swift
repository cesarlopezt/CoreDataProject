//
//  Candy+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Cesar Lopez on 4/1/23.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?

    public var wrappedName: String {
        name ?? "Unknown"
    }
}

extension Candy : Identifiable {

}
