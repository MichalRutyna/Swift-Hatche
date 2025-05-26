//
//  ContentView.swift
//  Hatche
//
//  Created by student on 05/05/2025.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var selectedhead: Equipment?
    @State private var selectedchestplate: Equipment?
    @State private var selectedlegs: Equipment?
    @State private var selectedboots: Equipment?
    
    @State private var selectedhands: Equipment?

    var body: some View {
        NavigationView {
            VStack {
                EquippedScoreView()
                HStack(spacing: 50) {
                    VStack(spacing: 50) {
                        ItemSlot(
                            selectedEquipment: $selectedhands,
                            slotType: ItemType.Hands
                        )
                    }
                    .padding()
                    
                    ClickableHatch(imageName: "1")
                    
                    
                    VStack(spacing: 50) {
                        ItemSlot(
                            selectedEquipment: $selectedhead,
                            slotType: ItemType.Head
                        )
                        ItemSlot(
                            selectedEquipment: $selectedchestplate,
                            slotType: ItemType.Chest
                        )
                        ItemSlot(
                            selectedEquipment: $selectedlegs,
                            slotType: ItemType.Legs
                        )
                        ItemSlot(
                            selectedEquipment: $selectedboots,
                            slotType: ItemType.Boots
                        )
                    }
                    .padding()
                    
                }
                .navigationTitle("Home")
            }
        }
    }
}


private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
