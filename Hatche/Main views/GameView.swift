//
//  GameView.swift
//  Hatche
//
//  Created by student on 02/06/2025.
//

import SwiftUI


struct GameView: View {
    var onSwitch: () -> Void
    @Environment(\.managedObjectContext) private var viewContext
    @State private var selectedhead: Equipment?
    @State private var selectedchestplate: Equipment?
    @State private var selectedlegs: Equipment?
    @State private var selectedboots: Equipment?
    
    @State private var selectedhands: Equipment?

    @Binding var chosenHatchObj: Hatch?
    

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    EquippedScoreView(hatch: $chosenHatchObj)
                    Button(action: {
                        onSwitch()
                    }) {
                        Text("Wybor hatcha")
                            .font(.headline)
                            .frame(maxWidth: 100)
                            .padding()
                            .cornerRadius(10)
                    }
                }
                HStack(spacing: 50) {
                    VStack(spacing: 50) {
                        ItemSlot(
                            hatch: $chosenHatchObj,
                            slotType: ItemType.Hands
                        )
                    }
                    .padding()
                    
                    ClickableHatch(imageName: chosenHatchObj!.image)
                    
                    VStack(spacing: 50) {
                        ItemSlot(
                            hatch: $chosenHatchObj,
                            slotType: ItemType.Head
                        )
                        ItemSlot(
                            hatch: $chosenHatchObj,
                            slotType: ItemType.Chest
                        )
                        ItemSlot(
                            hatch: $chosenHatchObj,
                            slotType: ItemType.Legs
                        )
                        ItemSlot(
                            hatch: $chosenHatchObj,
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
