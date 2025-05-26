//
//  ItemSlot.swift
//  Hatche
//
//  Created by student on 19/05/2025.
//

import SwiftUI

enum ItemType: String, CaseIterable {
    case Hands
    case Head
    case Chest
    case Legs
    case Boots
}

struct ItemSlot: View {
    @Binding public var selectedEquipment: Equipment?
    @Environment(\.managedObjectContext) private var viewContext
    
    let slotType: ItemType

    
    var body: some View {
        NavigationLink {
            EquipmentListView(onEquipmentSelected: { selected in
                equip(selected)
            }, slotType: slotType)
        }
        label: {
            if let equipment = selectedEquipment {
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
        }
        .buttonStyle(.borderedProminent)
    }
    
    private func equip(_ equipment: Equipment) {
            equipment.equipped = true
            do {
                try viewContext.save()
                selectedEquipment = equipment
            } catch {
                print("Failed to save equipped status: \(error.localizedDescription)")
            }
        }
}
