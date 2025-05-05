//
//  Equipment+CoreDataProperties.swift
//  Hatche
//
//  Created by student on 05/05/2025.
//
//

import Foundation
import CoreData


extension Equipment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Equipment> {
        return NSFetchRequest<Equipment>(entityName: "Equipment")
    }

    @NSManaged public var score: Int16
    @NSManaged public var name: String
    @NSManaged public var image: String
    @NSManaged public var equipped: Bool
    @NSManaged public var slot_type: String
    @NSManaged public var level: Int16
    @NSManaged public var drop_chance: Int16
    @NSManaged public var equipmentHatch: Hatch?

}

extension Equipment : Identifiable {

}
