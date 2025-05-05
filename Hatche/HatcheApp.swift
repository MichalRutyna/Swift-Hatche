//
//  HatcheApp.swift
//  Hatche
//
//  Created by student on 05/05/2025.
//

import SwiftUI

@main
struct HatcheApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
