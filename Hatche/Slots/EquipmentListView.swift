//
//  ItemListView.swift
//  Hatche
//
//  Created by student on 19/05/2025.
//

import SwiftUI

struct EquipmentListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @FetchRequest private var equipments: FetchedResults<Equipment>

    @State private var selectedForDetail: Equipment?
    
    let onEquipmentSelected: (Equipment) -> Void
    var slotType: ItemType
    
    init(
        onEquipmentSelected: @escaping (Equipment) -> Void,
        slotType: ItemType
    ) {
        self.slotType = slotType
            _equipments = FetchRequest(
                entity: Equipment.entity(),
                sortDescriptors: [NSSortDescriptor(keyPath: \Equipment.name, ascending: true)],
                predicate: NSPredicate(format: "slot_type == %@", slotType.rawValue)
            )
        
        self.onEquipmentSelected = onEquipmentSelected
        }


    var body: some View {
            List {
                ForEach(equipments) { equipment in
                    HStack {
                        Image(equipment.image)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .scaledToFit()
                        Text(equipment.name)
                            .font(.headline)
                    }
                    
                    .contentShape(Rectangle())
                    .onTapGesture {
                        onEquipmentSelected(equipment)
                        dismiss()
                    }
                    .background(
                        NavigationLink(
                            destination: EquipmentDetailsView(equipment: equipment),
                            tag: equipment,
                            selection: $selectedForDetail
                        ) {
                            EmptyView()
                        }
                            .hidden()
                    )
                    .swipeActions {
                        Button {
                            selectedForDetail = equipment
                        } label: {
                            Label("Details", systemImage: "info.circle")
                        }
                        .tint(.blue)
                    }
                }
            }
            .navigationTitle("Choose \(slotType.rawValue)")
    }
}
