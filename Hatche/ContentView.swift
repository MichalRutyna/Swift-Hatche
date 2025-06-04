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
    
    @State private var isInMenu = true
    @State private var chosenHatch: Hatch?

    var body: some View {
        if isInMenu {
            HatchSelectView(onSwitch: {
                isInMenu = false;
            }, chosenHatchObj: $chosenHatch)
        }
        else {
            GameView(onSwitch: {
                isInMenu = true;
            }, chosenHatchObj: $chosenHatch)
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
