//
//  Item+CoreDataClass.swift
//  Item
//
//  Created by Vetha on 10/11/24.
//
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    @NSManaged public var timestamp: Date?
}
