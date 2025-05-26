//
//  ItemDetailsView.swift
//  Hatche
//
//  Created by student on 19/05/2025.
//

import SwiftUI

struct EquipmentDetailsView: View {
    @ObservedObject var equipment: Equipment
    
    var body: some View {
        Image(equipment.image)
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 150)
            .padding()
        Text("\(equipment.name) ")
        Text("Score: \(equipment.score)")
        Text("Equipped: \(equipment.equipped)")
    }
}
