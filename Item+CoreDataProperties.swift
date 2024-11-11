//
//  Pet+CoreDataProperties.swift
//  Pets
//
//  Created by Vetha on 10/11/24.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var species: String?
    @NSManaged public var petDescription: String?
    @NSManaged public var lastSeenLatitude: Double
    @NSManaged public var lastSeenLongitude: Double
    @NSManaged public var photoData: Data?
    @NSManaged public var contactInfo: String?
    @NSManaged public var dateReported: Date?
    @NSManaged public var reportedByUserID: String?

}

extension Item : Identifiable {

}
