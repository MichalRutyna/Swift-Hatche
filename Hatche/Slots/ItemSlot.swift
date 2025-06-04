//
//  ItemSlot.swift
//  Hatche
//
//  Created by student on 19/05/2025.
//

import SwiftUI
import CoreData

enum ItemType: String, CaseIterable {
    case Hands
    case Head
    case Chest
    case Legs
    case Boots
}

struct ItemSlot: View {
    @Binding public var hatch: Hatch?
    @Environment(\.managedObjectContext) private var viewContext
    @State private var equipment: Equipment?
    let slotType: ItemType

    
    var body: some View {
        NavigationLink {
            EquipmentListView(onEquipmentSelected: { selected in
                equip(selected)
            }, slotType: slotType)
        }
        label: {
            if let equipment = equipment {
            Image(equipment.image)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 40)
        } else {
                Image("Empty")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 40)
            }
        }.onAppear {
            // fetch the equipment once when view appears
            self.equipment = fetchEquippedItemsBySlot(
                for: hatch!,
                slotType: slotType.rawValue.capitalized,
                context: viewContext
            )
        }
        .buttonStyle(.borderedProminent)
            
    }
    
    private func equip(_ equipment: Equipment) {
        let fetchRequest: NSFetchRequest<Equipment> = Equipment.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "equipped == true AND slot_type == %@ AND equipmentHatch == %@",
            slotType.rawValue,
            hatch!
        )
        do {
            let currentlyEquipped = try viewContext.fetch(fetchRequest)
            
            // should be just one but better to be safe
            for item in currentlyEquipped {
                item.equipped = false
            }
            equipment.equipped = true
            equipment.equipmentHatch = hatch
            
            try viewContext.save()
            
        } catch {
            print("Failed to save equipped status: \(error.localizedDescription)")
        }
    }
}
