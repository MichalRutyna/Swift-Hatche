//
//  FetchEquipped.swift
//  Hatche
//
//  Created by student on 02/06/2025.
//

import Foundation
import SwiftUI
import CoreData

func fetchEquippedItemsBySlot(
    for hatch: Hatch,
    slotType: String,
    context: NSManagedObjectContext
) -> Equipment? {
    
    var equippedItem: Equipment?
    let request: NSFetchRequest<Equipment> = Equipment.fetchRequest()
    request.predicate = NSPredicate(
        format: "equipmentHatch == %@ AND equipped == true AND slot_type == %@",
        hatch,
        slotType
    )
    request.fetchLimit = 1

    do {
        if let item = try context.fetch(request).first {
            equippedItem = item
        }
    } catch {
        
    }

    return equippedItem
}
