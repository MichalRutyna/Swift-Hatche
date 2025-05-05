//
//  Hatch+CoreDataProperties.swift
//  Hatche
//
//  Created by student on 05/05/2025.
//
//

import Foundation
import CoreData


extension Hatch {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hatch> {
        return NSFetchRequest<Hatch>(entityName: "Hatch")
    }

    @NSManaged public var type_name: String
    @NSManaged public var score: Int16
    @NSManaged public var image: String
    @NSManaged public var hatchEquipment: NSSet?
    
    public var equipment: [Equipment] {
        let set = hatchEquipment as? Set<Equipment> ?? []

     return set.sorted{
         $0.score < $1.score
     }

     }

}

// MARK: Generated accessors for hatchEquipment
extension Hatch {

    @objc(addHatchEquipmentObject:)
    @NSManaged public func addToHatchEquipment(_ value: Equipment)

    @objc(removeHatchEquipmentObject:)
    @NSManaged public func removeFromHatchEquipment(_ value: Equipment)

    @objc(addHatchEquipment:)
    @NSManaged public func addToHatchEquipment(_ values: NSSet)

    @objc(removeHatchEquipment:)
    @NSManaged public func removeFromHatchEquipment(_ values: NSSet)

}

extension Hatch : Identifiable {

}
