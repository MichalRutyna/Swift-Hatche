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

    @FetchRequest(
        entity: Equipment.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Equipment.name, ascending: true)]
    ) private var equipments: FetchedResults<Equipment>

    let onEquipmentSelected: (Equipment) -> Void
    @State private var selectedForDetail: Equipment?
    
    let slotType: ItemType


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
