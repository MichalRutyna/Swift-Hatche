//
//  getRandomitem.swift
//  Hatche
//
//  Created by student on 26/05/2025.
//

import Foundation
import SwiftUI
import CoreData

var materials = ["Diamond", "Golden", "Iron", "Netherite"]
var items = ["Boots", "Chestplate", "Helmet", "Leggings", "Sword"]
var types = ["Boots", "Chest", "Head", "Legs", "Hands"]

func getRandomItem(in viewContext: NSManagedObjectContext) -> Equipment {
    
    let material = materials.randomElement()
    let item_type = items.randomElement()
    
    let index = items.firstIndex(of: item_type!)
    let correspondingType = types[index!]
    
    
    let newItem = Equipment(context: viewContext)
    
    newItem.image = "\(material ?? "Diamond")_\(item_type ?? "Sword")"
    newItem.name = "\(material ?? "Diamond") \(item_type ?? "Sword")"
    newItem.slot_type = correspondingType
    newItem.score = Int16(Int.random(in: 100...400))
    
    do {
        try viewContext.save()
        return newItem
    } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
}
